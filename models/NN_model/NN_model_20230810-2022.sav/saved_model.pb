ло
э╜
.
Abs
x"T
y"T"
Ttype:

2	
D
AddV2
x"T
y"T
z"T"
Ttype:
2	АР
^
AssignVariableOp
resource
value"dtype"
dtypetype"
validate_shapebool( И
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
2
L2Loss
t"T
output"T"
Ttype:
2
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
Ж
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool("
allow_missing_filesbool( И
?
Mul
x"T
y"T
z"T"
Ttype:
2	Р

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetypeИ
@
RealDiv
x"T
y"T
z"T"
Ttype:
2	
E
Relu
features"T
activations"T"
Ttype:
2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
е
ResourceGather
resource
indices"Tindices
output"dtype"

batch_dimsint "
validate_indicesbool("
dtypetype"
Tindicestype:
2	И
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0И
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0И
?
Select
	condition

t"T
e"T
output"T"	
Ttype
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
0
Sigmoid
x"T
y"T"
Ttype:

2
┴
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring Ии
@
StaticRegexFullMatch	
input

output
"
patternstring
ў
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
М
Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
Ц
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 И"serve*2.10.02v2.10.0-rc3-6-g359c3cdfc5f8Ьў
~
Adam/dense_5/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:*$
shared_nameAdam/dense_5/bias/v
w
'Adam/dense_5/bias/v/Read/ReadVariableOpReadVariableOpAdam/dense_5/bias/v*
_output_shapes
:*
dtype0
Ж
Adam/dense_5/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
: *&
shared_nameAdam/dense_5/kernel/v

)Adam/dense_5/kernel/v/Read/ReadVariableOpReadVariableOpAdam/dense_5/kernel/v*
_output_shapes

: *
dtype0
~
Adam/dense_4/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape: *$
shared_nameAdam/dense_4/bias/v
w
'Adam/dense_4/bias/v/Read/ReadVariableOpReadVariableOpAdam/dense_4/bias/v*
_output_shapes
: *
dtype0
Ж
Adam/dense_4/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:  *&
shared_nameAdam/dense_4/kernel/v

)Adam/dense_4/kernel/v/Read/ReadVariableOpReadVariableOpAdam/dense_4/kernel/v*
_output_shapes

:  *
dtype0
~
Adam/dense_3/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape: *$
shared_nameAdam/dense_3/bias/v
w
'Adam/dense_3/bias/v/Read/ReadVariableOpReadVariableOpAdam/dense_3/bias/v*
_output_shapes
: *
dtype0
Ж
Adam/dense_3/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:} *&
shared_nameAdam/dense_3/kernel/v

)Adam/dense_3/kernel/v/Read/ReadVariableOpReadVariableOpAdam/dense_3/kernel/v*
_output_shapes

:} *
dtype0
г
#Adam/Player2-Embedding/embeddings/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:	╧*4
shared_name%#Adam/Player2-Embedding/embeddings/v
Ь
7Adam/Player2-Embedding/embeddings/v/Read/ReadVariableOpReadVariableOp#Adam/Player2-Embedding/embeddings/v*
_output_shapes
:	╧*
dtype0
г
#Adam/Player1-Embedding/embeddings/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:	╧*4
shared_name%#Adam/Player1-Embedding/embeddings/v
Ь
7Adam/Player1-Embedding/embeddings/v/Read/ReadVariableOpReadVariableOp#Adam/Player1-Embedding/embeddings/v*
_output_shapes
:	╧*
dtype0
~
Adam/dense_5/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:*$
shared_nameAdam/dense_5/bias/m
w
'Adam/dense_5/bias/m/Read/ReadVariableOpReadVariableOpAdam/dense_5/bias/m*
_output_shapes
:*
dtype0
Ж
Adam/dense_5/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
: *&
shared_nameAdam/dense_5/kernel/m

)Adam/dense_5/kernel/m/Read/ReadVariableOpReadVariableOpAdam/dense_5/kernel/m*
_output_shapes

: *
dtype0
~
Adam/dense_4/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape: *$
shared_nameAdam/dense_4/bias/m
w
'Adam/dense_4/bias/m/Read/ReadVariableOpReadVariableOpAdam/dense_4/bias/m*
_output_shapes
: *
dtype0
Ж
Adam/dense_4/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:  *&
shared_nameAdam/dense_4/kernel/m

)Adam/dense_4/kernel/m/Read/ReadVariableOpReadVariableOpAdam/dense_4/kernel/m*
_output_shapes

:  *
dtype0
~
Adam/dense_3/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape: *$
shared_nameAdam/dense_3/bias/m
w
'Adam/dense_3/bias/m/Read/ReadVariableOpReadVariableOpAdam/dense_3/bias/m*
_output_shapes
: *
dtype0
Ж
Adam/dense_3/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:} *&
shared_nameAdam/dense_3/kernel/m

)Adam/dense_3/kernel/m/Read/ReadVariableOpReadVariableOpAdam/dense_3/kernel/m*
_output_shapes

:} *
dtype0
г
#Adam/Player2-Embedding/embeddings/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:	╧*4
shared_name%#Adam/Player2-Embedding/embeddings/m
Ь
7Adam/Player2-Embedding/embeddings/m/Read/ReadVariableOpReadVariableOp#Adam/Player2-Embedding/embeddings/m*
_output_shapes
:	╧*
dtype0
г
#Adam/Player1-Embedding/embeddings/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:	╧*4
shared_name%#Adam/Player1-Embedding/embeddings/m
Ь
7Adam/Player1-Embedding/embeddings/m/Read/ReadVariableOpReadVariableOp#Adam/Player1-Embedding/embeddings/m*
_output_shapes
:	╧*
dtype0
^
countVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namecount
W
count/Read/ReadVariableOpReadVariableOpcount*
_output_shapes
: *
dtype0
^
totalVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nametotal
W
total/Read/ReadVariableOpReadVariableOptotal*
_output_shapes
: *
dtype0
b
count_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	count_1
[
count_1/Read/ReadVariableOpReadVariableOpcount_1*
_output_shapes
: *
dtype0
b
total_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	total_1
[
total_1/Read/ReadVariableOpReadVariableOptotal_1*
_output_shapes
: *
dtype0
x
Adam/learning_rateVarHandleOp*
_output_shapes
: *
dtype0*
shape: *#
shared_nameAdam/learning_rate
q
&Adam/learning_rate/Read/ReadVariableOpReadVariableOpAdam/learning_rate*
_output_shapes
: *
dtype0
h

Adam/decayVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name
Adam/decay
a
Adam/decay/Read/ReadVariableOpReadVariableOp
Adam/decay*
_output_shapes
: *
dtype0
j
Adam/beta_2VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameAdam/beta_2
c
Adam/beta_2/Read/ReadVariableOpReadVariableOpAdam/beta_2*
_output_shapes
: *
dtype0
j
Adam/beta_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameAdam/beta_1
c
Adam/beta_1/Read/ReadVariableOpReadVariableOpAdam/beta_1*
_output_shapes
: *
dtype0
f
	Adam/iterVarHandleOp*
_output_shapes
: *
dtype0	*
shape: *
shared_name	Adam/iter
_
Adam/iter/Read/ReadVariableOpReadVariableOp	Adam/iter*
_output_shapes
: *
dtype0	
p
dense_5/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_namedense_5/bias
i
 dense_5/bias/Read/ReadVariableOpReadVariableOpdense_5/bias*
_output_shapes
:*
dtype0
x
dense_5/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
: *
shared_namedense_5/kernel
q
"dense_5/kernel/Read/ReadVariableOpReadVariableOpdense_5/kernel*
_output_shapes

: *
dtype0
p
dense_4/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namedense_4/bias
i
 dense_4/bias/Read/ReadVariableOpReadVariableOpdense_4/bias*
_output_shapes
: *
dtype0
x
dense_4/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:  *
shared_namedense_4/kernel
q
"dense_4/kernel/Read/ReadVariableOpReadVariableOpdense_4/kernel*
_output_shapes

:  *
dtype0
p
dense_3/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namedense_3/bias
i
 dense_3/bias/Read/ReadVariableOpReadVariableOpdense_3/bias*
_output_shapes
: *
dtype0
x
dense_3/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:} *
shared_namedense_3/kernel
q
"dense_3/kernel/Read/ReadVariableOpReadVariableOpdense_3/kernel*
_output_shapes

:} *
dtype0
Х
Player2-Embedding/embeddingsVarHandleOp*
_output_shapes
: *
dtype0*
shape:	╧*-
shared_namePlayer2-Embedding/embeddings
О
0Player2-Embedding/embeddings/Read/ReadVariableOpReadVariableOpPlayer2-Embedding/embeddings*
_output_shapes
:	╧*
dtype0
Х
Player1-Embedding/embeddingsVarHandleOp*
_output_shapes
: *
dtype0*
shape:	╧*-
shared_namePlayer1-Embedding/embeddings
О
0Player1-Embedding/embeddings/Read/ReadVariableOpReadVariableOpPlayer1-Embedding/embeddings*
_output_shapes
:	╧*
dtype0
А
serving_default_Player1-InputPlaceholder*'
_output_shapes
:         *
dtype0*
shape:         
А
serving_default_Player2-InputPlaceholder*'
_output_shapes
:         *
dtype0*
shape:         
z
serving_default_X-InputPlaceholder*'
_output_shapes
:         s*
dtype0*
shape:         s
Ъ
StatefulPartitionedCallStatefulPartitionedCallserving_default_Player1-Inputserving_default_Player2-Inputserving_default_X-InputPlayer2-Embedding/embeddingsPlayer1-Embedding/embeddingsdense_3/kerneldense_3/biasdense_4/kerneldense_4/biasdense_5/kerneldense_5/bias*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         **
_read_only_resource_inputs

	
*0
config_proto 

CPU

GPU2*0J 8В *,
f'R%
#__inference_signature_wrapper_79409

NoOpNoOp
ОW
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*╔V
value┐VB╝V B╡V
·
layer-0
layer-1
layer_with_weights-0
layer-2
layer_with_weights-1
layer-3
layer-4
layer-5
layer-6
layer-7
	layer_with_weights-2
	layer-8

layer-9
layer_with_weights-3
layer-10
layer-11
layer_with_weights-4
layer-12
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
_default_save_signature
	optimizer

signatures*
* 
* 
а
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses

embeddings*
а
	variables
trainable_variables
 regularization_losses
!	keras_api
"__call__
*#&call_and_return_all_conditional_losses
$
embeddings*
* 
О
%	variables
&trainable_variables
'regularization_losses
(	keras_api
)__call__
**&call_and_return_all_conditional_losses* 
О
+	variables
,trainable_variables
-regularization_losses
.	keras_api
/__call__
*0&call_and_return_all_conditional_losses* 
О
1	variables
2trainable_variables
3regularization_losses
4	keras_api
5__call__
*6&call_and_return_all_conditional_losses* 
ж
7	variables
8trainable_variables
9regularization_losses
:	keras_api
;__call__
*<&call_and_return_all_conditional_losses

=kernel
>bias*
е
?	variables
@trainable_variables
Aregularization_losses
B	keras_api
C__call__
*D&call_and_return_all_conditional_losses
E_random_generator* 
ж
F	variables
Gtrainable_variables
Hregularization_losses
I	keras_api
J__call__
*K&call_and_return_all_conditional_losses

Lkernel
Mbias*
е
N	variables
Otrainable_variables
Pregularization_losses
Q	keras_api
R__call__
*S&call_and_return_all_conditional_losses
T_random_generator* 
ж
U	variables
Vtrainable_variables
Wregularization_losses
X	keras_api
Y__call__
*Z&call_and_return_all_conditional_losses

[kernel
\bias*
<
0
$1
=2
>3
L4
M5
[6
\7*
<
0
$1
=2
>3
L4
M5
[6
\7*

]0
^1* 
░
_non_trainable_variables

`layers
ametrics
blayer_regularization_losses
clayer_metrics
	variables
trainable_variables
regularization_losses
__call__
_default_save_signature
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*
6
dtrace_0
etrace_1
ftrace_2
gtrace_3* 
6
htrace_0
itrace_1
jtrace_2
ktrace_3* 
* 
ф
liter

mbeta_1

nbeta_2
	odecay
plearning_ratem╤$m╥=m╙>m╘Lm╒Mm╓[m╫\m╪v┘$v┌=v█>v▄Lv▌Mv▐[v▀\vр*

qserving_default* 

0*

0*
* 
У
rnon_trainable_variables

slayers
tmetrics
ulayer_regularization_losses
vlayer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*

wtrace_0* 

xtrace_0* 
pj
VARIABLE_VALUEPlayer1-Embedding/embeddings:layer_with_weights-0/embeddings/.ATTRIBUTES/VARIABLE_VALUE*

$0*

$0*
* 
У
ynon_trainable_variables

zlayers
{metrics
|layer_regularization_losses
}layer_metrics
	variables
trainable_variables
 regularization_losses
"__call__
*#&call_and_return_all_conditional_losses
&#"call_and_return_conditional_losses*

~trace_0* 

trace_0* 
pj
VARIABLE_VALUEPlayer2-Embedding/embeddings:layer_with_weights-1/embeddings/.ATTRIBUTES/VARIABLE_VALUE*
* 
* 
* 
Ц
Аnon_trainable_variables
Бlayers
Вmetrics
 Гlayer_regularization_losses
Дlayer_metrics
%	variables
&trainable_variables
'regularization_losses
)__call__
**&call_and_return_all_conditional_losses
&*"call_and_return_conditional_losses* 

Еtrace_0* 

Жtrace_0* 
* 
* 
* 
Ц
Зnon_trainable_variables
Иlayers
Йmetrics
 Кlayer_regularization_losses
Лlayer_metrics
+	variables
,trainable_variables
-regularization_losses
/__call__
*0&call_and_return_all_conditional_losses
&0"call_and_return_conditional_losses* 

Мtrace_0* 

Нtrace_0* 
* 
* 
* 
Ц
Оnon_trainable_variables
Пlayers
Рmetrics
 Сlayer_regularization_losses
Тlayer_metrics
1	variables
2trainable_variables
3regularization_losses
5__call__
*6&call_and_return_all_conditional_losses
&6"call_and_return_conditional_losses* 

Уtrace_0* 

Фtrace_0* 

=0
>1*

=0
>1*
	
]0* 
╖
Хnon_trainable_variables
Цlayers
Чmetrics
 Шlayer_regularization_losses
Щlayer_metrics
7	variables
8trainable_variables
9regularization_losses
;__call__
Ъactivity_regularizer_fn
*<&call_and_return_all_conditional_losses
'Ы"call_and_return_conditional_losses*

Ьtrace_0* 

Эtrace_0* 
^X
VARIABLE_VALUEdense_3/kernel6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUE*
ZT
VARIABLE_VALUEdense_3/bias4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUE*
* 
* 
* 
Ц
Юnon_trainable_variables
Яlayers
аmetrics
 бlayer_regularization_losses
вlayer_metrics
?	variables
@trainable_variables
Aregularization_losses
C__call__
*D&call_and_return_all_conditional_losses
&D"call_and_return_conditional_losses* 

гtrace_0
дtrace_1* 

еtrace_0
жtrace_1* 
* 

L0
M1*

L0
M1*
	
^0* 
╖
зnon_trainable_variables
иlayers
йmetrics
 кlayer_regularization_losses
лlayer_metrics
F	variables
Gtrainable_variables
Hregularization_losses
J__call__
мactivity_regularizer_fn
*K&call_and_return_all_conditional_losses
'н"call_and_return_conditional_losses*

оtrace_0* 

пtrace_0* 
^X
VARIABLE_VALUEdense_4/kernel6layer_with_weights-3/kernel/.ATTRIBUTES/VARIABLE_VALUE*
ZT
VARIABLE_VALUEdense_4/bias4layer_with_weights-3/bias/.ATTRIBUTES/VARIABLE_VALUE*
* 
* 
* 
Ц
░non_trainable_variables
▒layers
▓metrics
 │layer_regularization_losses
┤layer_metrics
N	variables
Otrainable_variables
Pregularization_losses
R__call__
*S&call_and_return_all_conditional_losses
&S"call_and_return_conditional_losses* 

╡trace_0
╢trace_1* 

╖trace_0
╕trace_1* 
* 

[0
\1*

[0
\1*
* 
Ш
╣non_trainable_variables
║layers
╗metrics
 ╝layer_regularization_losses
╜layer_metrics
U	variables
Vtrainable_variables
Wregularization_losses
Y__call__
*Z&call_and_return_all_conditional_losses
&Z"call_and_return_conditional_losses*

╛trace_0* 

┐trace_0* 
^X
VARIABLE_VALUEdense_5/kernel6layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUE*
ZT
VARIABLE_VALUEdense_5/bias4layer_with_weights-4/bias/.ATTRIBUTES/VARIABLE_VALUE*

└trace_0* 

┴trace_0* 
* 
b
0
1
2
3
4
5
6
7
	8

9
10
11
12*

┬0
├1*
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
LF
VARIABLE_VALUE	Adam/iter)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUE*
PJ
VARIABLE_VALUEAdam/beta_1+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUE*
PJ
VARIABLE_VALUEAdam/beta_2+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUE*
NH
VARIABLE_VALUE
Adam/decay*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUE*
^X
VARIABLE_VALUEAdam/learning_rate2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUE*
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
	
]0* 
* 

─trace_0* 

┼trace_0* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
	
^0* 
* 

╞trace_0* 

╟trace_0* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
<
╚	variables
╔	keras_api

╩total

╦count*
M
╠	variables
═	keras_api

╬total

╧count
╨
_fn_kwargs*
* 
* 
* 
* 

╩0
╦1*

╚	variables*
UO
VARIABLE_VALUEtotal_14keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUE*
UO
VARIABLE_VALUEcount_14keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUE*

╬0
╧1*

╠	variables*
SM
VARIABLE_VALUEtotal4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUE*
SM
VARIABLE_VALUEcount4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUE*
* 
ФН
VARIABLE_VALUE#Adam/Player1-Embedding/embeddings/mVlayer_with_weights-0/embeddings/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
ФН
VARIABLE_VALUE#Adam/Player2-Embedding/embeddings/mVlayer_with_weights-1/embeddings/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
Б{
VARIABLE_VALUEAdam/dense_3/kernel/mRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
}w
VARIABLE_VALUEAdam/dense_3/bias/mPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
Б{
VARIABLE_VALUEAdam/dense_4/kernel/mRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
}w
VARIABLE_VALUEAdam/dense_4/bias/mPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
Б{
VARIABLE_VALUEAdam/dense_5/kernel/mRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
}w
VARIABLE_VALUEAdam/dense_5/bias/mPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
ФН
VARIABLE_VALUE#Adam/Player1-Embedding/embeddings/vVlayer_with_weights-0/embeddings/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
ФН
VARIABLE_VALUE#Adam/Player2-Embedding/embeddings/vVlayer_with_weights-1/embeddings/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
Б{
VARIABLE_VALUEAdam/dense_3/kernel/vRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
}w
VARIABLE_VALUEAdam/dense_3/bias/vPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
Б{
VARIABLE_VALUEAdam/dense_4/kernel/vRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
}w
VARIABLE_VALUEAdam/dense_4/bias/vPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
Б{
VARIABLE_VALUEAdam/dense_5/kernel/vRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
}w
VARIABLE_VALUEAdam/dense_5/bias/vPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
щ
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename0Player1-Embedding/embeddings/Read/ReadVariableOp0Player2-Embedding/embeddings/Read/ReadVariableOp"dense_3/kernel/Read/ReadVariableOp dense_3/bias/Read/ReadVariableOp"dense_4/kernel/Read/ReadVariableOp dense_4/bias/Read/ReadVariableOp"dense_5/kernel/Read/ReadVariableOp dense_5/bias/Read/ReadVariableOpAdam/iter/Read/ReadVariableOpAdam/beta_1/Read/ReadVariableOpAdam/beta_2/Read/ReadVariableOpAdam/decay/Read/ReadVariableOp&Adam/learning_rate/Read/ReadVariableOptotal_1/Read/ReadVariableOpcount_1/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOp7Adam/Player1-Embedding/embeddings/m/Read/ReadVariableOp7Adam/Player2-Embedding/embeddings/m/Read/ReadVariableOp)Adam/dense_3/kernel/m/Read/ReadVariableOp'Adam/dense_3/bias/m/Read/ReadVariableOp)Adam/dense_4/kernel/m/Read/ReadVariableOp'Adam/dense_4/bias/m/Read/ReadVariableOp)Adam/dense_5/kernel/m/Read/ReadVariableOp'Adam/dense_5/bias/m/Read/ReadVariableOp7Adam/Player1-Embedding/embeddings/v/Read/ReadVariableOp7Adam/Player2-Embedding/embeddings/v/Read/ReadVariableOp)Adam/dense_3/kernel/v/Read/ReadVariableOp'Adam/dense_3/bias/v/Read/ReadVariableOp)Adam/dense_4/kernel/v/Read/ReadVariableOp'Adam/dense_4/bias/v/Read/ReadVariableOp)Adam/dense_5/kernel/v/Read/ReadVariableOp'Adam/dense_5/bias/v/Read/ReadVariableOpConst*.
Tin'
%2#	*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *'
f"R 
__inference__traced_save_80114
╨
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamePlayer1-Embedding/embeddingsPlayer2-Embedding/embeddingsdense_3/kerneldense_3/biasdense_4/kerneldense_4/biasdense_5/kerneldense_5/bias	Adam/iterAdam/beta_1Adam/beta_2
Adam/decayAdam/learning_ratetotal_1count_1totalcount#Adam/Player1-Embedding/embeddings/m#Adam/Player2-Embedding/embeddings/mAdam/dense_3/kernel/mAdam/dense_3/bias/mAdam/dense_4/kernel/mAdam/dense_4/bias/mAdam/dense_5/kernel/mAdam/dense_5/bias/m#Adam/Player1-Embedding/embeddings/v#Adam/Player2-Embedding/embeddings/vAdam/dense_3/kernel/vAdam/dense_3/bias/vAdam/dense_4/kernel/vAdam/dense_4/bias/vAdam/dense_5/kernel/vAdam/dense_5/bias/v*-
Tin&
$2"*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В **
f%R#
!__inference__traced_restore_80223╘├
╝
`
D__inference_flatten_3_layer_call_and_return_conditional_losses_79777

inputs
identityV
ConstConst*
_output_shapes
:*
dtype0*
valueB"       \
ReshapeReshapeinputsConst:output:0*
T0*'
_output_shapes
:         X
IdentityIdentityReshape:output:0*
T0*'
_output_shapes
:         "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         :S O
+
_output_shapes
:         
 
_user_specified_nameinputs
Є	
c
D__inference_dropout_3_layer_call_and_return_conditional_losses_79934

inputs
identityИR
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *n█6@d
dropout/MulMulinputsdropout/Const:output:0*
T0*'
_output_shapes
:          C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:М
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*'
_output_shapes
:          *
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *ff&?ж
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*'
_output_shapes
:          o
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*'
_output_shapes
:          i
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*'
_output_shapes
:          Y
IdentityIdentitydropout/Mul_1:z:0*
T0*'
_output_shapes
:          "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs
о
█
__inference_loss_fn_1_79990H
6dense_4_kernel_regularizer_abs_readvariableop_resource:  
identityИв-dense_4/kernel/Regularizer/Abs/ReadVariableOpв0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpe
 dense_4/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    д
-dense_4/kernel/Regularizer/Abs/ReadVariableOpReadVariableOp6dense_4_kernel_regularizer_abs_readvariableop_resource*
_output_shapes

:  *
dtype0Е
dense_4/kernel/Regularizer/AbsAbs5dense_4/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:  s
"dense_4/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_4/kernel/Regularizer/SumSum"dense_4/kernel/Regularizer/Abs:y:0+dense_4/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_4/kernel/Regularizer/mulMul)dense_4/kernel/Regularizer/mul/x:output:0'dense_4/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_4/kernel/Regularizer/addAddV2)dense_4/kernel/Regularizer/Const:output:0"dense_4/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: з
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOp6dense_4_kernel_regularizer_abs_readvariableop_resource*
_output_shapes

:  *
dtype0Ж
!dense_4/kernel/Regularizer/L2LossL2Loss8dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_4/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_4/kernel/Regularizer/mul_1Mul+dense_4/kernel/Regularizer/mul_1/x:output:0*dense_4/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_4/kernel/Regularizer/add_1AddV2"dense_4/kernel/Regularizer/add:z:0$dense_4/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: b
IdentityIdentity$dense_4/kernel/Regularizer/add_1:z:0^NoOp*
T0*
_output_shapes
: й
NoOpNoOp.^dense_4/kernel/Regularizer/Abs/ReadVariableOp1^dense_4/kernel/Regularizer/L2Loss/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: 2^
-dense_4/kernel/Regularizer/Abs/ReadVariableOp-dense_4/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp
┴
Ф
'__inference_dense_4_layer_call_fn_79872

inputs
unknown:  
	unknown_0: 
identityИвStatefulPartitionedCall┌
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_4_layer_call_and_return_conditional_losses_78825o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:          `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:          : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:          
 
_user_specified_nameinputs
▀i
Ж
B__inference_model_1_layer_call_and_return_conditional_losses_79352
x_input
player1_input
player2_input*
player2_embedding_79281:	╧*
player1_embedding_79284:	╧
dense_3_79290:} 
dense_3_79292: 
dense_4_79304:  
dense_4_79306: 
dense_5_79318: 
dense_5_79320:
identity

identity_1

identity_2Ив)Player1-Embedding/StatefulPartitionedCallв)Player2-Embedding/StatefulPartitionedCallвdense_3/StatefulPartitionedCallв-dense_3/kernel/Regularizer/Abs/ReadVariableOpв0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpвdense_4/StatefulPartitionedCallв-dense_4/kernel/Regularizer/Abs/ReadVariableOpв0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpвdense_5/StatefulPartitionedCallв!dropout_2/StatefulPartitionedCallв!dropout_3/StatefulPartitionedCallД
)Player2-Embedding/StatefulPartitionedCallStatefulPartitionedCallplayer2_inputplayer2_embedding_79281*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_78712Д
)Player1-Embedding/StatefulPartitionedCallStatefulPartitionedCallplayer1_inputplayer1_embedding_79284*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_78726ш
flatten_2/PartitionedCallPartitionedCall2Player1-Embedding/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_2_layer_call_and_return_conditional_losses_78736ш
flatten_3/PartitionedCallPartitionedCall2Player2-Embedding/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_3_layer_call_and_return_conditional_losses_78744П
concatenate_1/PartitionedCallPartitionedCallx_input"flatten_2/PartitionedCall:output:0"flatten_3/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         }* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *Q
fLRJ
H__inference_concatenate_1_layer_call_and_return_conditional_losses_78754М
dense_3/StatefulPartitionedCallStatefulPartitionedCall&concatenate_1/PartitionedCall:output:0dense_3_79290dense_3_79292*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_3_layer_call_and_return_conditional_losses_78780╔
+dense_3/ActivityRegularizer/PartitionedCallPartitionedCall(dense_3/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_3_activity_regularizer_78672y
!dense_3/ActivityRegularizer/ShapeShape(dense_3/StatefulPartitionedCall:output:0*
T0*
_output_shapes
:y
/dense_3/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_3/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_3/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_3/ActivityRegularizer/strided_sliceStridedSlice*dense_3/ActivityRegularizer/Shape:output:08dense_3/ActivityRegularizer/strided_slice/stack:output:0:dense_3/ActivityRegularizer/strided_slice/stack_1:output:0:dense_3/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_3/ActivityRegularizer/CastCast2dense_3/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: л
#dense_3/ActivityRegularizer/truedivRealDiv4dense_3/ActivityRegularizer/PartitionedCall:output:0$dense_3/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: ю
!dropout_2/StatefulPartitionedCallStatefulPartitionedCall(dense_3/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_2_layer_call_and_return_conditional_losses_78988Р
dense_4/StatefulPartitionedCallStatefulPartitionedCall*dropout_2/StatefulPartitionedCall:output:0dense_4_79304dense_4_79306*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_4_layer_call_and_return_conditional_losses_78825╔
+dense_4/ActivityRegularizer/PartitionedCallPartitionedCall(dense_4/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_4_activity_regularizer_78691y
!dense_4/ActivityRegularizer/ShapeShape(dense_4/StatefulPartitionedCall:output:0*
T0*
_output_shapes
:y
/dense_4/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_4/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_4/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_4/ActivityRegularizer/strided_sliceStridedSlice*dense_4/ActivityRegularizer/Shape:output:08dense_4/ActivityRegularizer/strided_slice/stack:output:0:dense_4/ActivityRegularizer/strided_slice/stack_1:output:0:dense_4/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_4/ActivityRegularizer/CastCast2dense_4/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: л
#dense_4/ActivityRegularizer/truedivRealDiv4dense_4/ActivityRegularizer/PartitionedCall:output:0$dense_4/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: Т
!dropout_3/StatefulPartitionedCallStatefulPartitionedCall(dense_4/StatefulPartitionedCall:output:0"^dropout_2/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_3_layer_call_and_return_conditional_losses_78943Р
dense_5/StatefulPartitionedCallStatefulPartitionedCall*dropout_3/StatefulPartitionedCall:output:0dense_5_79318dense_5_79320*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_5_layer_call_and_return_conditional_losses_78857e
 dense_3/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    {
-dense_3/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpdense_3_79290*
_output_shapes

:} *
dtype0Е
dense_3/kernel/Regularizer/AbsAbs5dense_3/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:} s
"dense_3/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_3/kernel/Regularizer/SumSum"dense_3/kernel/Regularizer/Abs:y:0+dense_3/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_3/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_3/kernel/Regularizer/mulMul)dense_3/kernel/Regularizer/mul/x:output:0'dense_3/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_3/kernel/Regularizer/addAddV2)dense_3/kernel/Regularizer/Const:output:0"dense_3/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: ~
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpdense_3_79290*
_output_shapes

:} *
dtype0Ж
!dense_3/kernel/Regularizer/L2LossL2Loss8dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_3/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_3/kernel/Regularizer/mul_1Mul+dense_3/kernel/Regularizer/mul_1/x:output:0*dense_3/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_3/kernel/Regularizer/add_1AddV2"dense_3/kernel/Regularizer/add:z:0$dense_3/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    {
-dense_4/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpdense_4_79304*
_output_shapes

:  *
dtype0Е
dense_4/kernel/Regularizer/AbsAbs5dense_4/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:  s
"dense_4/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_4/kernel/Regularizer/SumSum"dense_4/kernel/Regularizer/Abs:y:0+dense_4/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_4/kernel/Regularizer/mulMul)dense_4/kernel/Regularizer/mul/x:output:0'dense_4/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_4/kernel/Regularizer/addAddV2)dense_4/kernel/Regularizer/Const:output:0"dense_4/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: ~
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpdense_4_79304*
_output_shapes

:  *
dtype0Ж
!dense_4/kernel/Regularizer/L2LossL2Loss8dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_4/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_4/kernel/Regularizer/mul_1Mul+dense_4/kernel/Regularizer/mul_1/x:output:0*dense_4/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_4/kernel/Regularizer/add_1AddV2"dense_4/kernel/Regularizer/add:z:0$dense_4/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: w
IdentityIdentity(dense_5/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         g

Identity_1Identity'dense_3/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: g

Identity_2Identity'dense_4/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: Т
NoOpNoOp*^Player1-Embedding/StatefulPartitionedCall*^Player2-Embedding/StatefulPartitionedCall ^dense_3/StatefulPartitionedCall.^dense_3/kernel/Regularizer/Abs/ReadVariableOp1^dense_3/kernel/Regularizer/L2Loss/ReadVariableOp ^dense_4/StatefulPartitionedCall.^dense_4/kernel/Regularizer/Abs/ReadVariableOp1^dense_4/kernel/Regularizer/L2Loss/ReadVariableOp ^dense_5/StatefulPartitionedCall"^dropout_2/StatefulPartitionedCall"^dropout_3/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 2V
)Player1-Embedding/StatefulPartitionedCall)Player1-Embedding/StatefulPartitionedCall2V
)Player2-Embedding/StatefulPartitionedCall)Player2-Embedding/StatefulPartitionedCall2B
dense_3/StatefulPartitionedCalldense_3/StatefulPartitionedCall2^
-dense_3/kernel/Regularizer/Abs/ReadVariableOp-dense_3/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp2B
dense_4/StatefulPartitionedCalldense_4/StatefulPartitionedCall2^
-dense_4/kernel/Regularizer/Abs/ReadVariableOp-dense_4/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp2B
dense_5/StatefulPartitionedCalldense_5/StatefulPartitionedCall2F
!dropout_2/StatefulPartitionedCall!dropout_2/StatefulPartitionedCall2F
!dropout_3/StatefulPartitionedCall!dropout_3/StatefulPartitionedCall:P L
'
_output_shapes
:         s
!
_user_specified_name	X-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer1-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer2-Input
┴
Ф
'__inference_dense_3_layer_call_fn_79801

inputs
unknown:} 
	unknown_0: 
identityИвStatefulPartitionedCall┌
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_3_layer_call_and_return_conditional_losses_78780o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:          `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         }: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:         }
 
_user_specified_nameinputs
╝
`
D__inference_flatten_2_layer_call_and_return_conditional_losses_79766

inputs
identityV
ConstConst*
_output_shapes
:*
dtype0*
valueB"       \
ReshapeReshapeinputsConst:output:0*
T0*'
_output_shapes
:         X
IdentityIdentityReshape:output:0*
T0*'
_output_shapes
:         "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         :S O
+
_output_shapes
:         
 
_user_specified_nameinputs
ш
у
'__inference_model_1_layer_call_fn_79200
x_input
player1_input
player2_input
unknown:	╧
	unknown_0:	╧
	unknown_1:} 
	unknown_2: 
	unknown_3:  
	unknown_4: 
	unknown_5: 
	unknown_6:
identityИвStatefulPartitionedCall╧
StatefulPartitionedCallStatefulPartitionedCallx_inputplayer1_inputplayer2_inputunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         : : **
_read_only_resource_inputs

	
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_model_1_layer_call_and_return_conditional_losses_79154o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:P L
'
_output_shapes
:         s
!
_user_specified_name	X-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer1-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer2-Input
╞f
│
B__inference_model_1_layer_call_and_return_conditional_losses_78892

inputs
inputs_1
inputs_2*
player2_embedding_78713:	╧*
player1_embedding_78727:	╧
dense_3_78781:} 
dense_3_78783: 
dense_4_78826:  
dense_4_78828: 
dense_5_78858: 
dense_5_78860:
identity

identity_1

identity_2Ив)Player1-Embedding/StatefulPartitionedCallв)Player2-Embedding/StatefulPartitionedCallвdense_3/StatefulPartitionedCallв-dense_3/kernel/Regularizer/Abs/ReadVariableOpв0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpвdense_4/StatefulPartitionedCallв-dense_4/kernel/Regularizer/Abs/ReadVariableOpв0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpвdense_5/StatefulPartitionedCall 
)Player2-Embedding/StatefulPartitionedCallStatefulPartitionedCallinputs_2player2_embedding_78713*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_78712 
)Player1-Embedding/StatefulPartitionedCallStatefulPartitionedCallinputs_1player1_embedding_78727*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_78726ш
flatten_2/PartitionedCallPartitionedCall2Player1-Embedding/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_2_layer_call_and_return_conditional_losses_78736ш
flatten_3/PartitionedCallPartitionedCall2Player2-Embedding/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_3_layer_call_and_return_conditional_losses_78744О
concatenate_1/PartitionedCallPartitionedCallinputs"flatten_2/PartitionedCall:output:0"flatten_3/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         }* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *Q
fLRJ
H__inference_concatenate_1_layer_call_and_return_conditional_losses_78754М
dense_3/StatefulPartitionedCallStatefulPartitionedCall&concatenate_1/PartitionedCall:output:0dense_3_78781dense_3_78783*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_3_layer_call_and_return_conditional_losses_78780╔
+dense_3/ActivityRegularizer/PartitionedCallPartitionedCall(dense_3/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_3_activity_regularizer_78672y
!dense_3/ActivityRegularizer/ShapeShape(dense_3/StatefulPartitionedCall:output:0*
T0*
_output_shapes
:y
/dense_3/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_3/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_3/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_3/ActivityRegularizer/strided_sliceStridedSlice*dense_3/ActivityRegularizer/Shape:output:08dense_3/ActivityRegularizer/strided_slice/stack:output:0:dense_3/ActivityRegularizer/strided_slice/stack_1:output:0:dense_3/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_3/ActivityRegularizer/CastCast2dense_3/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: л
#dense_3/ActivityRegularizer/truedivRealDiv4dense_3/ActivityRegularizer/PartitionedCall:output:0$dense_3/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: ▐
dropout_2/PartitionedCallPartitionedCall(dense_3/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_2_layer_call_and_return_conditional_losses_78799И
dense_4/StatefulPartitionedCallStatefulPartitionedCall"dropout_2/PartitionedCall:output:0dense_4_78826dense_4_78828*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_4_layer_call_and_return_conditional_losses_78825╔
+dense_4/ActivityRegularizer/PartitionedCallPartitionedCall(dense_4/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_4_activity_regularizer_78691y
!dense_4/ActivityRegularizer/ShapeShape(dense_4/StatefulPartitionedCall:output:0*
T0*
_output_shapes
:y
/dense_4/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_4/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_4/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_4/ActivityRegularizer/strided_sliceStridedSlice*dense_4/ActivityRegularizer/Shape:output:08dense_4/ActivityRegularizer/strided_slice/stack:output:0:dense_4/ActivityRegularizer/strided_slice/stack_1:output:0:dense_4/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_4/ActivityRegularizer/CastCast2dense_4/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: л
#dense_4/ActivityRegularizer/truedivRealDiv4dense_4/ActivityRegularizer/PartitionedCall:output:0$dense_4/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: ▐
dropout_3/PartitionedCallPartitionedCall(dense_4/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_3_layer_call_and_return_conditional_losses_78844И
dense_5/StatefulPartitionedCallStatefulPartitionedCall"dropout_3/PartitionedCall:output:0dense_5_78858dense_5_78860*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_5_layer_call_and_return_conditional_losses_78857e
 dense_3/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    {
-dense_3/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpdense_3_78781*
_output_shapes

:} *
dtype0Е
dense_3/kernel/Regularizer/AbsAbs5dense_3/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:} s
"dense_3/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_3/kernel/Regularizer/SumSum"dense_3/kernel/Regularizer/Abs:y:0+dense_3/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_3/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_3/kernel/Regularizer/mulMul)dense_3/kernel/Regularizer/mul/x:output:0'dense_3/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_3/kernel/Regularizer/addAddV2)dense_3/kernel/Regularizer/Const:output:0"dense_3/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: ~
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpdense_3_78781*
_output_shapes

:} *
dtype0Ж
!dense_3/kernel/Regularizer/L2LossL2Loss8dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_3/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_3/kernel/Regularizer/mul_1Mul+dense_3/kernel/Regularizer/mul_1/x:output:0*dense_3/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_3/kernel/Regularizer/add_1AddV2"dense_3/kernel/Regularizer/add:z:0$dense_3/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    {
-dense_4/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpdense_4_78826*
_output_shapes

:  *
dtype0Е
dense_4/kernel/Regularizer/AbsAbs5dense_4/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:  s
"dense_4/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_4/kernel/Regularizer/SumSum"dense_4/kernel/Regularizer/Abs:y:0+dense_4/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_4/kernel/Regularizer/mulMul)dense_4/kernel/Regularizer/mul/x:output:0'dense_4/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_4/kernel/Regularizer/addAddV2)dense_4/kernel/Regularizer/Const:output:0"dense_4/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: ~
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpdense_4_78826*
_output_shapes

:  *
dtype0Ж
!dense_4/kernel/Regularizer/L2LossL2Loss8dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_4/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_4/kernel/Regularizer/mul_1Mul+dense_4/kernel/Regularizer/mul_1/x:output:0*dense_4/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_4/kernel/Regularizer/add_1AddV2"dense_4/kernel/Regularizer/add:z:0$dense_4/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: w
IdentityIdentity(dense_5/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         g

Identity_1Identity'dense_3/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: g

Identity_2Identity'dense_4/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: ╩
NoOpNoOp*^Player1-Embedding/StatefulPartitionedCall*^Player2-Embedding/StatefulPartitionedCall ^dense_3/StatefulPartitionedCall.^dense_3/kernel/Regularizer/Abs/ReadVariableOp1^dense_3/kernel/Regularizer/L2Loss/ReadVariableOp ^dense_4/StatefulPartitionedCall.^dense_4/kernel/Regularizer/Abs/ReadVariableOp1^dense_4/kernel/Regularizer/L2Loss/ReadVariableOp ^dense_5/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 2V
)Player1-Embedding/StatefulPartitionedCall)Player1-Embedding/StatefulPartitionedCall2V
)Player2-Embedding/StatefulPartitionedCall)Player2-Embedding/StatefulPartitionedCall2B
dense_3/StatefulPartitionedCalldense_3/StatefulPartitionedCall2^
-dense_3/kernel/Regularizer/Abs/ReadVariableOp-dense_3/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp2B
dense_4/StatefulPartitionedCalldense_4/StatefulPartitionedCall2^
-dense_4/kernel/Regularizer/Abs/ReadVariableOp-dense_4/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp2B
dense_5/StatefulPartitionedCalldense_5/StatefulPartitionedCall:O K
'
_output_shapes
:         s
 
_user_specified_nameinputs:OK
'
_output_shapes
:         
 
_user_specified_nameinputs:OK
'
_output_shapes
:         
 
_user_specified_nameinputs
Р
╓
B__inference_dense_4_layer_call_and_return_conditional_losses_79907

inputs0
matmul_readvariableop_resource:  -
biasadd_readvariableop_resource: 
identityИвBiasAdd/ReadVariableOpвMatMul/ReadVariableOpв-dense_4/kernel/Regularizer/Abs/ReadVariableOpв0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:  *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
: *
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:          e
 dense_4/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    М
-dense_4/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:  *
dtype0Е
dense_4/kernel/Regularizer/AbsAbs5dense_4/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:  s
"dense_4/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_4/kernel/Regularizer/SumSum"dense_4/kernel/Regularizer/Abs:y:0+dense_4/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_4/kernel/Regularizer/mulMul)dense_4/kernel/Regularizer/mul/x:output:0'dense_4/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_4/kernel/Regularizer/addAddV2)dense_4/kernel/Regularizer/Const:output:0"dense_4/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: П
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:  *
dtype0Ж
!dense_4/kernel/Regularizer/L2LossL2Loss8dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_4/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_4/kernel/Regularizer/mul_1Mul+dense_4/kernel/Regularizer/mul_1/x:output:0*dense_4/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_4/kernel/Regularizer/add_1AddV2"dense_4/kernel/Regularizer/add:z:0$dense_4/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:          ┌
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp.^dense_4/kernel/Regularizer/Abs/ReadVariableOp1^dense_4/kernel/Regularizer/L2Loss/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:          : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp2^
-dense_4/kernel/Regularizer/Abs/ReadVariableOp-dense_4/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:O K
'
_output_shapes
:          
 
_user_specified_nameinputs
Ш

є
B__inference_dense_5_layer_call_and_return_conditional_losses_79954

inputs0
matmul_readvariableop_resource: -
biasadd_readvariableop_resource:
identityИвBiasAdd/ReadVariableOpвMatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

: *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         V
SigmoidSigmoidBiasAdd:output:0*
T0*'
_output_shapes
:         Z
IdentityIdentitySigmoid:y:0^NoOp*
T0*'
_output_shapes
:         w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:          : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:          
 
_user_specified_nameinputs
┴
Ф
'__inference_dense_5_layer_call_fn_79943

inputs
unknown: 
	unknown_0:
identityИвStatefulPartitionedCall┌
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_5_layer_call_and_return_conditional_losses_78857o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:          : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:          
 
_user_specified_nameinputs
ыf
╛
B__inference_model_1_layer_call_and_return_conditional_losses_79276
x_input
player1_input
player2_input*
player2_embedding_79205:	╧*
player1_embedding_79208:	╧
dense_3_79214:} 
dense_3_79216: 
dense_4_79228:  
dense_4_79230: 
dense_5_79242: 
dense_5_79244:
identity

identity_1

identity_2Ив)Player1-Embedding/StatefulPartitionedCallв)Player2-Embedding/StatefulPartitionedCallвdense_3/StatefulPartitionedCallв-dense_3/kernel/Regularizer/Abs/ReadVariableOpв0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpвdense_4/StatefulPartitionedCallв-dense_4/kernel/Regularizer/Abs/ReadVariableOpв0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpвdense_5/StatefulPartitionedCallД
)Player2-Embedding/StatefulPartitionedCallStatefulPartitionedCallplayer2_inputplayer2_embedding_79205*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_78712Д
)Player1-Embedding/StatefulPartitionedCallStatefulPartitionedCallplayer1_inputplayer1_embedding_79208*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_78726ш
flatten_2/PartitionedCallPartitionedCall2Player1-Embedding/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_2_layer_call_and_return_conditional_losses_78736ш
flatten_3/PartitionedCallPartitionedCall2Player2-Embedding/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_3_layer_call_and_return_conditional_losses_78744П
concatenate_1/PartitionedCallPartitionedCallx_input"flatten_2/PartitionedCall:output:0"flatten_3/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         }* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *Q
fLRJ
H__inference_concatenate_1_layer_call_and_return_conditional_losses_78754М
dense_3/StatefulPartitionedCallStatefulPartitionedCall&concatenate_1/PartitionedCall:output:0dense_3_79214dense_3_79216*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_3_layer_call_and_return_conditional_losses_78780╔
+dense_3/ActivityRegularizer/PartitionedCallPartitionedCall(dense_3/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_3_activity_regularizer_78672y
!dense_3/ActivityRegularizer/ShapeShape(dense_3/StatefulPartitionedCall:output:0*
T0*
_output_shapes
:y
/dense_3/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_3/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_3/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_3/ActivityRegularizer/strided_sliceStridedSlice*dense_3/ActivityRegularizer/Shape:output:08dense_3/ActivityRegularizer/strided_slice/stack:output:0:dense_3/ActivityRegularizer/strided_slice/stack_1:output:0:dense_3/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_3/ActivityRegularizer/CastCast2dense_3/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: л
#dense_3/ActivityRegularizer/truedivRealDiv4dense_3/ActivityRegularizer/PartitionedCall:output:0$dense_3/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: ▐
dropout_2/PartitionedCallPartitionedCall(dense_3/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_2_layer_call_and_return_conditional_losses_78799И
dense_4/StatefulPartitionedCallStatefulPartitionedCall"dropout_2/PartitionedCall:output:0dense_4_79228dense_4_79230*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_4_layer_call_and_return_conditional_losses_78825╔
+dense_4/ActivityRegularizer/PartitionedCallPartitionedCall(dense_4/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_4_activity_regularizer_78691y
!dense_4/ActivityRegularizer/ShapeShape(dense_4/StatefulPartitionedCall:output:0*
T0*
_output_shapes
:y
/dense_4/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_4/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_4/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_4/ActivityRegularizer/strided_sliceStridedSlice*dense_4/ActivityRegularizer/Shape:output:08dense_4/ActivityRegularizer/strided_slice/stack:output:0:dense_4/ActivityRegularizer/strided_slice/stack_1:output:0:dense_4/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_4/ActivityRegularizer/CastCast2dense_4/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: л
#dense_4/ActivityRegularizer/truedivRealDiv4dense_4/ActivityRegularizer/PartitionedCall:output:0$dense_4/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: ▐
dropout_3/PartitionedCallPartitionedCall(dense_4/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_3_layer_call_and_return_conditional_losses_78844И
dense_5/StatefulPartitionedCallStatefulPartitionedCall"dropout_3/PartitionedCall:output:0dense_5_79242dense_5_79244*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_5_layer_call_and_return_conditional_losses_78857e
 dense_3/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    {
-dense_3/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpdense_3_79214*
_output_shapes

:} *
dtype0Е
dense_3/kernel/Regularizer/AbsAbs5dense_3/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:} s
"dense_3/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_3/kernel/Regularizer/SumSum"dense_3/kernel/Regularizer/Abs:y:0+dense_3/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_3/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_3/kernel/Regularizer/mulMul)dense_3/kernel/Regularizer/mul/x:output:0'dense_3/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_3/kernel/Regularizer/addAddV2)dense_3/kernel/Regularizer/Const:output:0"dense_3/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: ~
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpdense_3_79214*
_output_shapes

:} *
dtype0Ж
!dense_3/kernel/Regularizer/L2LossL2Loss8dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_3/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_3/kernel/Regularizer/mul_1Mul+dense_3/kernel/Regularizer/mul_1/x:output:0*dense_3/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_3/kernel/Regularizer/add_1AddV2"dense_3/kernel/Regularizer/add:z:0$dense_3/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    {
-dense_4/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpdense_4_79228*
_output_shapes

:  *
dtype0Е
dense_4/kernel/Regularizer/AbsAbs5dense_4/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:  s
"dense_4/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_4/kernel/Regularizer/SumSum"dense_4/kernel/Regularizer/Abs:y:0+dense_4/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_4/kernel/Regularizer/mulMul)dense_4/kernel/Regularizer/mul/x:output:0'dense_4/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_4/kernel/Regularizer/addAddV2)dense_4/kernel/Regularizer/Const:output:0"dense_4/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: ~
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpdense_4_79228*
_output_shapes

:  *
dtype0Ж
!dense_4/kernel/Regularizer/L2LossL2Loss8dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_4/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_4/kernel/Regularizer/mul_1Mul+dense_4/kernel/Regularizer/mul_1/x:output:0*dense_4/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_4/kernel/Regularizer/add_1AddV2"dense_4/kernel/Regularizer/add:z:0$dense_4/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: w
IdentityIdentity(dense_5/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         g

Identity_1Identity'dense_3/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: g

Identity_2Identity'dense_4/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: ╩
NoOpNoOp*^Player1-Embedding/StatefulPartitionedCall*^Player2-Embedding/StatefulPartitionedCall ^dense_3/StatefulPartitionedCall.^dense_3/kernel/Regularizer/Abs/ReadVariableOp1^dense_3/kernel/Regularizer/L2Loss/ReadVariableOp ^dense_4/StatefulPartitionedCall.^dense_4/kernel/Regularizer/Abs/ReadVariableOp1^dense_4/kernel/Regularizer/L2Loss/ReadVariableOp ^dense_5/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 2V
)Player1-Embedding/StatefulPartitionedCall)Player1-Embedding/StatefulPartitionedCall2V
)Player2-Embedding/StatefulPartitionedCall)Player2-Embedding/StatefulPartitionedCall2B
dense_3/StatefulPartitionedCalldense_3/StatefulPartitionedCall2^
-dense_3/kernel/Regularizer/Abs/ReadVariableOp-dense_3/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp2B
dense_4/StatefulPartitionedCalldense_4/StatefulPartitionedCall2^
-dense_4/kernel/Regularizer/Abs/ReadVariableOp-dense_4/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp2B
dense_5/StatefulPartitionedCalldense_5/StatefulPartitionedCall:P L
'
_output_shapes
:         s
!
_user_specified_name	X-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer1-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer2-Input
Ш

є
B__inference_dense_5_layer_call_and_return_conditional_losses_78857

inputs0
matmul_readvariableop_resource: -
biasadd_readvariableop_resource:
identityИвBiasAdd/ReadVariableOpвMatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

: *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         V
SigmoidSigmoidBiasAdd:output:0*
T0*'
_output_shapes
:         Z
IdentityIdentitySigmoid:y:0^NoOp*
T0*'
_output_shapes
:         w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:          : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:          
 
_user_specified_nameinputs
Є
b
)__inference_dropout_3_layer_call_fn_79917

inputs
identityИвStatefulPartitionedCall┬
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_3_layer_call_and_return_conditional_losses_78943o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:          `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:          
 
_user_specified_nameinputs
м

E
.__inference_dense_4_activity_regularizer_78691
x
identityJ
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    0
AbsAbsx*
T0*
_output_shapes
:6
RankRankAbs:y:0*
T0*
_output_shapes
: M
range/startConst*
_output_shapes
: *
dtype0*
value	B : M
range/deltaConst*
_output_shapes
: *
dtype0*
value	B :n
rangeRangerange/start:output:0Rank:output:0range/delta:output:0*#
_output_shapes
:         D
SumSumAbs:y:0range:output:0*
T0*
_output_shapes
: J
mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3I
mulMulmul/x:output:0Sum:output:0*
T0*
_output_shapes
: F
addAddV2Const:output:0mul:z:0*
T0*
_output_shapes
: 4
L2LossL2Lossx*
T0*
_output_shapes
: L
mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4P
mul_1Mulmul_1/x:output:0L2Loss:output:0*
T0*
_output_shapes
: C
add_1AddV2add:z:0	mul_1:z:0*
T0*
_output_shapes
: @
IdentityIdentity	add_1:z:0*
T0*
_output_shapes
: "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
::; 7

_output_shapes
:

_user_specified_namex
╫
b
D__inference_dropout_2_layer_call_and_return_conditional_losses_79851

inputs

identity_1N
IdentityIdentityinputs*
T0*'
_output_shapes
:          [

Identity_1IdentityIdentity:output:0*
T0*'
_output_shapes
:          "!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs
ш
у
'__inference_model_1_layer_call_fn_78913
x_input
player1_input
player2_input
unknown:	╧
	unknown_0:	╧
	unknown_1:} 
	unknown_2: 
	unknown_3:  
	unknown_4: 
	unknown_5: 
	unknown_6:
identityИвStatefulPartitionedCall╧
StatefulPartitionedCallStatefulPartitionedCallx_inputplayer1_inputplayer2_inputunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         : : **
_read_only_resource_inputs

	
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_model_1_layer_call_and_return_conditional_losses_78892o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:P L
'
_output_shapes
:         s
!
_user_specified_name	X-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer1-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer2-Input
Х
├
F__inference_dense_4_layer_call_and_return_all_conditional_losses_79883

inputs
unknown:  
	unknown_0: 
identity

identity_1ИвStatefulPartitionedCall┌
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_4_layer_call_and_return_conditional_losses_78825е
PartitionedCallPartitionedCall StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_4_activity_regularizer_78691o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:          X

Identity_1IdentityPartitionedCall:output:0^NoOp*
T0*
_output_shapes
: `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:          : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:          
 
_user_specified_nameinputs
Є	
c
D__inference_dropout_2_layer_call_and_return_conditional_losses_79863

inputs
identityИR
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *n█6@d
dropout/MulMulinputsdropout/Const:output:0*
T0*'
_output_shapes
:          C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:М
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*'
_output_shapes
:          *
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *ff&?ж
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*'
_output_shapes
:          o
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*'
_output_shapes
:          i
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*'
_output_shapes
:          Y
IdentityIdentitydropout/Mul_1:z:0*
T0*'
_output_shapes
:          "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs
м
g
-__inference_concatenate_1_layer_call_fn_79784
inputs_0
inputs_1
inputs_2
identity╬
PartitionedCallPartitionedCallinputs_0inputs_1inputs_2*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         }* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *Q
fLRJ
H__inference_concatenate_1_layer_call_and_return_conditional_losses_78754`
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:         }"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:         s:         :         :Q M
'
_output_shapes
:         s
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/2
эБ
┐
B__inference_model_1_layer_call_and_return_conditional_losses_79596
inputs_0
inputs_1
inputs_2;
(player2_embedding_embedding_lookup_79491:	╧;
(player1_embedding_embedding_lookup_79497:	╧8
&dense_3_matmul_readvariableop_resource:} 5
'dense_3_biasadd_readvariableop_resource: 8
&dense_4_matmul_readvariableop_resource:  5
'dense_4_biasadd_readvariableop_resource: 8
&dense_5_matmul_readvariableop_resource: 5
'dense_5_biasadd_readvariableop_resource:
identity

identity_1

identity_2Ив"Player1-Embedding/embedding_lookupв"Player2-Embedding/embedding_lookupвdense_3/BiasAdd/ReadVariableOpвdense_3/MatMul/ReadVariableOpв-dense_3/kernel/Regularizer/Abs/ReadVariableOpв0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpвdense_4/BiasAdd/ReadVariableOpвdense_4/MatMul/ReadVariableOpв-dense_4/kernel/Regularizer/Abs/ReadVariableOpв0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpвdense_5/BiasAdd/ReadVariableOpвdense_5/MatMul/ReadVariableOpi
Player2-Embedding/CastCastinputs_2*

DstT0*

SrcT0*'
_output_shapes
:         Б
"Player2-Embedding/embedding_lookupResourceGather(player2_embedding_embedding_lookup_79491Player2-Embedding/Cast:y:0*
Tindices0*;
_class1
/-loc:@Player2-Embedding/embedding_lookup/79491*+
_output_shapes
:         *
dtype0╫
+Player2-Embedding/embedding_lookup/IdentityIdentity+Player2-Embedding/embedding_lookup:output:0*
T0*;
_class1
/-loc:@Player2-Embedding/embedding_lookup/79491*+
_output_shapes
:         е
-Player2-Embedding/embedding_lookup/Identity_1Identity4Player2-Embedding/embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         i
Player1-Embedding/CastCastinputs_1*

DstT0*

SrcT0*'
_output_shapes
:         Б
"Player1-Embedding/embedding_lookupResourceGather(player1_embedding_embedding_lookup_79497Player1-Embedding/Cast:y:0*
Tindices0*;
_class1
/-loc:@Player1-Embedding/embedding_lookup/79497*+
_output_shapes
:         *
dtype0╫
+Player1-Embedding/embedding_lookup/IdentityIdentity+Player1-Embedding/embedding_lookup:output:0*
T0*;
_class1
/-loc:@Player1-Embedding/embedding_lookup/79497*+
_output_shapes
:         е
-Player1-Embedding/embedding_lookup/Identity_1Identity4Player1-Embedding/embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         `
flatten_2/ConstConst*
_output_shapes
:*
dtype0*
valueB"       а
flatten_2/ReshapeReshape6Player1-Embedding/embedding_lookup/Identity_1:output:0flatten_2/Const:output:0*
T0*'
_output_shapes
:         `
flatten_3/ConstConst*
_output_shapes
:*
dtype0*
valueB"       а
flatten_3/ReshapeReshape6Player2-Embedding/embedding_lookup/Identity_1:output:0flatten_3/Const:output:0*
T0*'
_output_shapes
:         [
concatenate_1/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :┴
concatenate_1/concatConcatV2inputs_0flatten_2/Reshape:output:0flatten_3/Reshape:output:0"concatenate_1/concat/axis:output:0*
N*
T0*'
_output_shapes
:         }Д
dense_3/MatMul/ReadVariableOpReadVariableOp&dense_3_matmul_readvariableop_resource*
_output_shapes

:} *
dtype0Р
dense_3/MatMulMatMulconcatenate_1/concat:output:0%dense_3/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          В
dense_3/BiasAdd/ReadVariableOpReadVariableOp'dense_3_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0О
dense_3/BiasAddBiasAdddense_3/MatMul:product:0&dense_3/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          `
dense_3/ReluReludense_3/BiasAdd:output:0*
T0*'
_output_shapes
:          f
!dense_3/ActivityRegularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    t
dense_3/ActivityRegularizer/AbsAbsdense_3/Relu:activations:0*
T0*'
_output_shapes
:          t
#dense_3/ActivityRegularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ъ
dense_3/ActivityRegularizer/SumSum#dense_3/ActivityRegularizer/Abs:y:0,dense_3/ActivityRegularizer/Const_1:output:0*
T0*
_output_shapes
: f
!dense_3/ActivityRegularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Э
dense_3/ActivityRegularizer/mulMul*dense_3/ActivityRegularizer/mul/x:output:0(dense_3/ActivityRegularizer/Sum:output:0*
T0*
_output_shapes
: Ъ
dense_3/ActivityRegularizer/addAddV2*dense_3/ActivityRegularizer/Const:output:0#dense_3/ActivityRegularizer/mul:z:0*
T0*
_output_shapes
: i
"dense_3/ActivityRegularizer/L2LossL2Lossdense_3/Relu:activations:0*
T0*
_output_shapes
: h
#dense_3/ActivityRegularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4д
!dense_3/ActivityRegularizer/mul_1Mul,dense_3/ActivityRegularizer/mul_1/x:output:0+dense_3/ActivityRegularizer/L2Loss:output:0*
T0*
_output_shapes
: Ч
!dense_3/ActivityRegularizer/add_1AddV2#dense_3/ActivityRegularizer/add:z:0%dense_3/ActivityRegularizer/mul_1:z:0*
T0*
_output_shapes
: k
!dense_3/ActivityRegularizer/ShapeShapedense_3/Relu:activations:0*
T0*
_output_shapes
:y
/dense_3/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_3/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_3/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_3/ActivityRegularizer/strided_sliceStridedSlice*dense_3/ActivityRegularizer/Shape:output:08dense_3/ActivityRegularizer/strided_slice/stack:output:0:dense_3/ActivityRegularizer/strided_slice/stack_1:output:0:dense_3/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_3/ActivityRegularizer/CastCast2dense_3/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: Ь
#dense_3/ActivityRegularizer/truedivRealDiv%dense_3/ActivityRegularizer/add_1:z:0$dense_3/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: l
dropout_2/IdentityIdentitydense_3/Relu:activations:0*
T0*'
_output_shapes
:          Д
dense_4/MatMul/ReadVariableOpReadVariableOp&dense_4_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0О
dense_4/MatMulMatMuldropout_2/Identity:output:0%dense_4/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          В
dense_4/BiasAdd/ReadVariableOpReadVariableOp'dense_4_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0О
dense_4/BiasAddBiasAdddense_4/MatMul:product:0&dense_4/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          `
dense_4/ReluReludense_4/BiasAdd:output:0*
T0*'
_output_shapes
:          f
!dense_4/ActivityRegularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    t
dense_4/ActivityRegularizer/AbsAbsdense_4/Relu:activations:0*
T0*'
_output_shapes
:          t
#dense_4/ActivityRegularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ъ
dense_4/ActivityRegularizer/SumSum#dense_4/ActivityRegularizer/Abs:y:0,dense_4/ActivityRegularizer/Const_1:output:0*
T0*
_output_shapes
: f
!dense_4/ActivityRegularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Э
dense_4/ActivityRegularizer/mulMul*dense_4/ActivityRegularizer/mul/x:output:0(dense_4/ActivityRegularizer/Sum:output:0*
T0*
_output_shapes
: Ъ
dense_4/ActivityRegularizer/addAddV2*dense_4/ActivityRegularizer/Const:output:0#dense_4/ActivityRegularizer/mul:z:0*
T0*
_output_shapes
: i
"dense_4/ActivityRegularizer/L2LossL2Lossdense_4/Relu:activations:0*
T0*
_output_shapes
: h
#dense_4/ActivityRegularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4д
!dense_4/ActivityRegularizer/mul_1Mul,dense_4/ActivityRegularizer/mul_1/x:output:0+dense_4/ActivityRegularizer/L2Loss:output:0*
T0*
_output_shapes
: Ч
!dense_4/ActivityRegularizer/add_1AddV2#dense_4/ActivityRegularizer/add:z:0%dense_4/ActivityRegularizer/mul_1:z:0*
T0*
_output_shapes
: k
!dense_4/ActivityRegularizer/ShapeShapedense_4/Relu:activations:0*
T0*
_output_shapes
:y
/dense_4/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_4/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_4/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_4/ActivityRegularizer/strided_sliceStridedSlice*dense_4/ActivityRegularizer/Shape:output:08dense_4/ActivityRegularizer/strided_slice/stack:output:0:dense_4/ActivityRegularizer/strided_slice/stack_1:output:0:dense_4/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_4/ActivityRegularizer/CastCast2dense_4/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: Ь
#dense_4/ActivityRegularizer/truedivRealDiv%dense_4/ActivityRegularizer/add_1:z:0$dense_4/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: l
dropout_3/IdentityIdentitydense_4/Relu:activations:0*
T0*'
_output_shapes
:          Д
dense_5/MatMul/ReadVariableOpReadVariableOp&dense_5_matmul_readvariableop_resource*
_output_shapes

: *
dtype0О
dense_5/MatMulMatMuldropout_3/Identity:output:0%dense_5/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         В
dense_5/BiasAdd/ReadVariableOpReadVariableOp'dense_5_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0О
dense_5/BiasAddBiasAdddense_5/MatMul:product:0&dense_5/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         f
dense_5/SigmoidSigmoiddense_5/BiasAdd:output:0*
T0*'
_output_shapes
:         e
 dense_3/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    Ф
-dense_3/kernel/Regularizer/Abs/ReadVariableOpReadVariableOp&dense_3_matmul_readvariableop_resource*
_output_shapes

:} *
dtype0Е
dense_3/kernel/Regularizer/AbsAbs5dense_3/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:} s
"dense_3/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_3/kernel/Regularizer/SumSum"dense_3/kernel/Regularizer/Abs:y:0+dense_3/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_3/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_3/kernel/Regularizer/mulMul)dense_3/kernel/Regularizer/mul/x:output:0'dense_3/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_3/kernel/Regularizer/addAddV2)dense_3/kernel/Regularizer/Const:output:0"dense_3/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: Ч
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOp&dense_3_matmul_readvariableop_resource*
_output_shapes

:} *
dtype0Ж
!dense_3/kernel/Regularizer/L2LossL2Loss8dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_3/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_3/kernel/Regularizer/mul_1Mul+dense_3/kernel/Regularizer/mul_1/x:output:0*dense_3/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_3/kernel/Regularizer/add_1AddV2"dense_3/kernel/Regularizer/add:z:0$dense_3/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    Ф
-dense_4/kernel/Regularizer/Abs/ReadVariableOpReadVariableOp&dense_4_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0Е
dense_4/kernel/Regularizer/AbsAbs5dense_4/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:  s
"dense_4/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_4/kernel/Regularizer/SumSum"dense_4/kernel/Regularizer/Abs:y:0+dense_4/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_4/kernel/Regularizer/mulMul)dense_4/kernel/Regularizer/mul/x:output:0'dense_4/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_4/kernel/Regularizer/addAddV2)dense_4/kernel/Regularizer/Const:output:0"dense_4/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: Ч
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOp&dense_4_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0Ж
!dense_4/kernel/Regularizer/L2LossL2Loss8dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_4/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_4/kernel/Regularizer/mul_1Mul+dense_4/kernel/Regularizer/mul_1/x:output:0*dense_4/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_4/kernel/Regularizer/add_1AddV2"dense_4/kernel/Regularizer/add:z:0$dense_4/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: b
IdentityIdentitydense_5/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:         g

Identity_1Identity'dense_3/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: g

Identity_2Identity'dense_4/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: Щ
NoOpNoOp#^Player1-Embedding/embedding_lookup#^Player2-Embedding/embedding_lookup^dense_3/BiasAdd/ReadVariableOp^dense_3/MatMul/ReadVariableOp.^dense_3/kernel/Regularizer/Abs/ReadVariableOp1^dense_3/kernel/Regularizer/L2Loss/ReadVariableOp^dense_4/BiasAdd/ReadVariableOp^dense_4/MatMul/ReadVariableOp.^dense_4/kernel/Regularizer/Abs/ReadVariableOp1^dense_4/kernel/Regularizer/L2Loss/ReadVariableOp^dense_5/BiasAdd/ReadVariableOp^dense_5/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 2H
"Player1-Embedding/embedding_lookup"Player1-Embedding/embedding_lookup2H
"Player2-Embedding/embedding_lookup"Player2-Embedding/embedding_lookup2@
dense_3/BiasAdd/ReadVariableOpdense_3/BiasAdd/ReadVariableOp2>
dense_3/MatMul/ReadVariableOpdense_3/MatMul/ReadVariableOp2^
-dense_3/kernel/Regularizer/Abs/ReadVariableOp-dense_3/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp2@
dense_4/BiasAdd/ReadVariableOpdense_4/BiasAdd/ReadVariableOp2>
dense_4/MatMul/ReadVariableOpdense_4/MatMul/ReadVariableOp2^
-dense_4/kernel/Regularizer/Abs/ReadVariableOp-dense_4/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp2@
dense_5/BiasAdd/ReadVariableOpdense_5/BiasAdd/ReadVariableOp2>
dense_5/MatMul/ReadVariableOpdense_5/MatMul/ReadVariableOp:Q M
'
_output_shapes
:         s
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/2
╫
b
D__inference_dropout_2_layer_call_and_return_conditional_losses_78799

inputs

identity_1N
IdentityIdentityinputs*
T0*'
_output_shapes
:          [

Identity_1IdentityIdentity:output:0*
T0*'
_output_shapes
:          "!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs
╝
`
D__inference_flatten_3_layer_call_and_return_conditional_losses_78744

inputs
identityV
ConstConst*
_output_shapes
:*
dtype0*
valueB"       \
ReshapeReshapeinputsConst:output:0*
T0*'
_output_shapes
:         X
IdentityIdentityReshape:output:0*
T0*'
_output_shapes
:         "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         :S O
+
_output_shapes
:         
 
_user_specified_nameinputs
═
┌
'__inference_model_1_layer_call_fn_79460
inputs_0
inputs_1
inputs_2
unknown:	╧
	unknown_0:	╧
	unknown_1:} 
	unknown_2: 
	unknown_3:  
	unknown_4: 
	unknown_5: 
	unknown_6:
identityИвStatefulPartitionedCall╞
StatefulPartitionedCallStatefulPartitionedCallinputs_0inputs_1inputs_2unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         : : **
_read_only_resource_inputs

	
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_model_1_layer_call_and_return_conditional_losses_78892o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:Q M
'
_output_shapes
:         s
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/2
║i
√
B__inference_model_1_layer_call_and_return_conditional_losses_79154

inputs
inputs_1
inputs_2*
player2_embedding_79083:	╧*
player1_embedding_79086:	╧
dense_3_79092:} 
dense_3_79094: 
dense_4_79106:  
dense_4_79108: 
dense_5_79120: 
dense_5_79122:
identity

identity_1

identity_2Ив)Player1-Embedding/StatefulPartitionedCallв)Player2-Embedding/StatefulPartitionedCallвdense_3/StatefulPartitionedCallв-dense_3/kernel/Regularizer/Abs/ReadVariableOpв0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpвdense_4/StatefulPartitionedCallв-dense_4/kernel/Regularizer/Abs/ReadVariableOpв0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpвdense_5/StatefulPartitionedCallв!dropout_2/StatefulPartitionedCallв!dropout_3/StatefulPartitionedCall 
)Player2-Embedding/StatefulPartitionedCallStatefulPartitionedCallinputs_2player2_embedding_79083*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_78712 
)Player1-Embedding/StatefulPartitionedCallStatefulPartitionedCallinputs_1player1_embedding_79086*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_78726ш
flatten_2/PartitionedCallPartitionedCall2Player1-Embedding/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_2_layer_call_and_return_conditional_losses_78736ш
flatten_3/PartitionedCallPartitionedCall2Player2-Embedding/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_3_layer_call_and_return_conditional_losses_78744О
concatenate_1/PartitionedCallPartitionedCallinputs"flatten_2/PartitionedCall:output:0"flatten_3/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         }* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *Q
fLRJ
H__inference_concatenate_1_layer_call_and_return_conditional_losses_78754М
dense_3/StatefulPartitionedCallStatefulPartitionedCall&concatenate_1/PartitionedCall:output:0dense_3_79092dense_3_79094*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_3_layer_call_and_return_conditional_losses_78780╔
+dense_3/ActivityRegularizer/PartitionedCallPartitionedCall(dense_3/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_3_activity_regularizer_78672y
!dense_3/ActivityRegularizer/ShapeShape(dense_3/StatefulPartitionedCall:output:0*
T0*
_output_shapes
:y
/dense_3/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_3/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_3/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_3/ActivityRegularizer/strided_sliceStridedSlice*dense_3/ActivityRegularizer/Shape:output:08dense_3/ActivityRegularizer/strided_slice/stack:output:0:dense_3/ActivityRegularizer/strided_slice/stack_1:output:0:dense_3/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_3/ActivityRegularizer/CastCast2dense_3/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: л
#dense_3/ActivityRegularizer/truedivRealDiv4dense_3/ActivityRegularizer/PartitionedCall:output:0$dense_3/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: ю
!dropout_2/StatefulPartitionedCallStatefulPartitionedCall(dense_3/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_2_layer_call_and_return_conditional_losses_78988Р
dense_4/StatefulPartitionedCallStatefulPartitionedCall*dropout_2/StatefulPartitionedCall:output:0dense_4_79106dense_4_79108*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_4_layer_call_and_return_conditional_losses_78825╔
+dense_4/ActivityRegularizer/PartitionedCallPartitionedCall(dense_4/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_4_activity_regularizer_78691y
!dense_4/ActivityRegularizer/ShapeShape(dense_4/StatefulPartitionedCall:output:0*
T0*
_output_shapes
:y
/dense_4/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_4/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_4/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_4/ActivityRegularizer/strided_sliceStridedSlice*dense_4/ActivityRegularizer/Shape:output:08dense_4/ActivityRegularizer/strided_slice/stack:output:0:dense_4/ActivityRegularizer/strided_slice/stack_1:output:0:dense_4/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_4/ActivityRegularizer/CastCast2dense_4/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: л
#dense_4/ActivityRegularizer/truedivRealDiv4dense_4/ActivityRegularizer/PartitionedCall:output:0$dense_4/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: Т
!dropout_3/StatefulPartitionedCallStatefulPartitionedCall(dense_4/StatefulPartitionedCall:output:0"^dropout_2/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_3_layer_call_and_return_conditional_losses_78943Р
dense_5/StatefulPartitionedCallStatefulPartitionedCall*dropout_3/StatefulPartitionedCall:output:0dense_5_79120dense_5_79122*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_5_layer_call_and_return_conditional_losses_78857e
 dense_3/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    {
-dense_3/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpdense_3_79092*
_output_shapes

:} *
dtype0Е
dense_3/kernel/Regularizer/AbsAbs5dense_3/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:} s
"dense_3/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_3/kernel/Regularizer/SumSum"dense_3/kernel/Regularizer/Abs:y:0+dense_3/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_3/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_3/kernel/Regularizer/mulMul)dense_3/kernel/Regularizer/mul/x:output:0'dense_3/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_3/kernel/Regularizer/addAddV2)dense_3/kernel/Regularizer/Const:output:0"dense_3/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: ~
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpdense_3_79092*
_output_shapes

:} *
dtype0Ж
!dense_3/kernel/Regularizer/L2LossL2Loss8dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_3/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_3/kernel/Regularizer/mul_1Mul+dense_3/kernel/Regularizer/mul_1/x:output:0*dense_3/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_3/kernel/Regularizer/add_1AddV2"dense_3/kernel/Regularizer/add:z:0$dense_3/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    {
-dense_4/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpdense_4_79106*
_output_shapes

:  *
dtype0Е
dense_4/kernel/Regularizer/AbsAbs5dense_4/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:  s
"dense_4/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_4/kernel/Regularizer/SumSum"dense_4/kernel/Regularizer/Abs:y:0+dense_4/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_4/kernel/Regularizer/mulMul)dense_4/kernel/Regularizer/mul/x:output:0'dense_4/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_4/kernel/Regularizer/addAddV2)dense_4/kernel/Regularizer/Const:output:0"dense_4/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: ~
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpdense_4_79106*
_output_shapes

:  *
dtype0Ж
!dense_4/kernel/Regularizer/L2LossL2Loss8dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_4/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_4/kernel/Regularizer/mul_1Mul+dense_4/kernel/Regularizer/mul_1/x:output:0*dense_4/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_4/kernel/Regularizer/add_1AddV2"dense_4/kernel/Regularizer/add:z:0$dense_4/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: w
IdentityIdentity(dense_5/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         g

Identity_1Identity'dense_3/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: g

Identity_2Identity'dense_4/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: Т
NoOpNoOp*^Player1-Embedding/StatefulPartitionedCall*^Player2-Embedding/StatefulPartitionedCall ^dense_3/StatefulPartitionedCall.^dense_3/kernel/Regularizer/Abs/ReadVariableOp1^dense_3/kernel/Regularizer/L2Loss/ReadVariableOp ^dense_4/StatefulPartitionedCall.^dense_4/kernel/Regularizer/Abs/ReadVariableOp1^dense_4/kernel/Regularizer/L2Loss/ReadVariableOp ^dense_5/StatefulPartitionedCall"^dropout_2/StatefulPartitionedCall"^dropout_3/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 2V
)Player1-Embedding/StatefulPartitionedCall)Player1-Embedding/StatefulPartitionedCall2V
)Player2-Embedding/StatefulPartitionedCall)Player2-Embedding/StatefulPartitionedCall2B
dense_3/StatefulPartitionedCalldense_3/StatefulPartitionedCall2^
-dense_3/kernel/Regularizer/Abs/ReadVariableOp-dense_3/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp2B
dense_4/StatefulPartitionedCalldense_4/StatefulPartitionedCall2^
-dense_4/kernel/Regularizer/Abs/ReadVariableOp-dense_4/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp2B
dense_5/StatefulPartitionedCalldense_5/StatefulPartitionedCall2F
!dropout_2/StatefulPartitionedCall!dropout_2/StatefulPartitionedCall2F
!dropout_3/StatefulPartitionedCall!dropout_3/StatefulPartitionedCall:O K
'
_output_shapes
:         s
 
_user_specified_nameinputs:OK
'
_output_shapes
:         
 
_user_specified_nameinputs:OK
'
_output_shapes
:         
 
_user_specified_nameinputs
Р
╓
B__inference_dense_3_layer_call_and_return_conditional_losses_78780

inputs0
matmul_readvariableop_resource:} -
biasadd_readvariableop_resource: 
identityИвBiasAdd/ReadVariableOpвMatMul/ReadVariableOpв-dense_3/kernel/Regularizer/Abs/ReadVariableOpв0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:} *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
: *
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:          e
 dense_3/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    М
-dense_3/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:} *
dtype0Е
dense_3/kernel/Regularizer/AbsAbs5dense_3/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:} s
"dense_3/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_3/kernel/Regularizer/SumSum"dense_3/kernel/Regularizer/Abs:y:0+dense_3/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_3/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_3/kernel/Regularizer/mulMul)dense_3/kernel/Regularizer/mul/x:output:0'dense_3/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_3/kernel/Regularizer/addAddV2)dense_3/kernel/Regularizer/Const:output:0"dense_3/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: П
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:} *
dtype0Ж
!dense_3/kernel/Regularizer/L2LossL2Loss8dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_3/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_3/kernel/Regularizer/mul_1Mul+dense_3/kernel/Regularizer/mul_1/x:output:0*dense_3/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_3/kernel/Regularizer/add_1AddV2"dense_3/kernel/Regularizer/add:z:0$dense_3/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:          ┌
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp.^dense_3/kernel/Regularizer/Abs/ReadVariableOp1^dense_3/kernel/Regularizer/L2Loss/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         }: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp2^
-dense_3/kernel/Regularizer/Abs/ReadVariableOp-dense_3/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:O K
'
_output_shapes
:         }
 
_user_specified_nameinputs
═
┌
'__inference_model_1_layer_call_fn_79485
inputs_0
inputs_1
inputs_2
unknown:	╧
	unknown_0:	╧
	unknown_1:} 
	unknown_2: 
	unknown_3:  
	unknown_4: 
	unknown_5: 
	unknown_6:
identityИвStatefulPartitionedCall╞
StatefulPartitionedCallStatefulPartitionedCallinputs_0inputs_1inputs_2unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         : : **
_read_only_resource_inputs

	
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_model_1_layer_call_and_return_conditional_losses_79154o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:Q M
'
_output_shapes
:         s
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/2
е	
й
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_79738

inputs)
embedding_lookup_79732:	╧
identityИвembedding_lookupU
CastCastinputs*

DstT0*

SrcT0*'
_output_shapes
:         ╣
embedding_lookupResourceGatherembedding_lookup_79732Cast:y:0*
Tindices0*)
_class
loc:@embedding_lookup/79732*+
_output_shapes
:         *
dtype0б
embedding_lookup/IdentityIdentityembedding_lookup:output:0*
T0*)
_class
loc:@embedding_lookup/79732*+
_output_shapes
:         Б
embedding_lookup/Identity_1Identity"embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         w
IdentityIdentity$embedding_lookup/Identity_1:output:0^NoOp*
T0*+
_output_shapes
:         Y
NoOpNoOp^embedding_lookup*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*(
_input_shapes
:         : 2$
embedding_lookupembedding_lookup:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
м

E
.__inference_dense_3_activity_regularizer_78672
x
identityJ
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    0
AbsAbsx*
T0*
_output_shapes
:6
RankRankAbs:y:0*
T0*
_output_shapes
: M
range/startConst*
_output_shapes
: *
dtype0*
value	B : M
range/deltaConst*
_output_shapes
: *
dtype0*
value	B :n
rangeRangerange/start:output:0Rank:output:0range/delta:output:0*#
_output_shapes
:         D
SumSumAbs:y:0range:output:0*
T0*
_output_shapes
: J
mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3I
mulMulmul/x:output:0Sum:output:0*
T0*
_output_shapes
: F
addAddV2Const:output:0mul:z:0*
T0*
_output_shapes
: 4
L2LossL2Lossx*
T0*
_output_shapes
: L
mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4P
mul_1Mulmul_1/x:output:0L2Loss:output:0*
T0*
_output_shapes
: C
add_1AddV2add:z:0	mul_1:z:0*
T0*
_output_shapes
: @
IdentityIdentity	add_1:z:0*
T0*
_output_shapes
: "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
::; 7

_output_shapes
:

_user_specified_namex
╫
b
D__inference_dropout_3_layer_call_and_return_conditional_losses_79922

inputs

identity_1N
IdentityIdentityinputs*
T0*'
_output_shapes
:          [

Identity_1IdentityIdentity:output:0*
T0*'
_output_shapes
:          "!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs
Є	
c
D__inference_dropout_3_layer_call_and_return_conditional_losses_78943

inputs
identityИR
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *n█6@d
dropout/MulMulinputsdropout/Const:output:0*
T0*'
_output_shapes
:          C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:М
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*'
_output_shapes
:          *
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *ff&?ж
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*'
_output_shapes
:          o
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*'
_output_shapes
:          i
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*'
_output_shapes
:          Y
IdentityIdentitydropout/Mul_1:z:0*
T0*'
_output_shapes
:          "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs
е	
й
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_78712

inputs)
embedding_lookup_78706:	╧
identityИвembedding_lookupU
CastCastinputs*

DstT0*

SrcT0*'
_output_shapes
:         ╣
embedding_lookupResourceGatherembedding_lookup_78706Cast:y:0*
Tindices0*)
_class
loc:@embedding_lookup/78706*+
_output_shapes
:         *
dtype0б
embedding_lookup/IdentityIdentityembedding_lookup:output:0*
T0*)
_class
loc:@embedding_lookup/78706*+
_output_shapes
:         Б
embedding_lookup/Identity_1Identity"embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         w
IdentityIdentity$embedding_lookup/Identity_1:output:0^NoOp*
T0*+
_output_shapes
:         Y
NoOpNoOp^embedding_lookup*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*(
_input_shapes
:         : 2$
embedding_lookupembedding_lookup:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
єР
┐
B__inference_model_1_layer_call_and_return_conditional_losses_79721
inputs_0
inputs_1
inputs_2;
(player2_embedding_embedding_lookup_79602:	╧;
(player1_embedding_embedding_lookup_79608:	╧8
&dense_3_matmul_readvariableop_resource:} 5
'dense_3_biasadd_readvariableop_resource: 8
&dense_4_matmul_readvariableop_resource:  5
'dense_4_biasadd_readvariableop_resource: 8
&dense_5_matmul_readvariableop_resource: 5
'dense_5_biasadd_readvariableop_resource:
identity

identity_1

identity_2Ив"Player1-Embedding/embedding_lookupв"Player2-Embedding/embedding_lookupвdense_3/BiasAdd/ReadVariableOpвdense_3/MatMul/ReadVariableOpв-dense_3/kernel/Regularizer/Abs/ReadVariableOpв0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpвdense_4/BiasAdd/ReadVariableOpвdense_4/MatMul/ReadVariableOpв-dense_4/kernel/Regularizer/Abs/ReadVariableOpв0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpвdense_5/BiasAdd/ReadVariableOpвdense_5/MatMul/ReadVariableOpi
Player2-Embedding/CastCastinputs_2*

DstT0*

SrcT0*'
_output_shapes
:         Б
"Player2-Embedding/embedding_lookupResourceGather(player2_embedding_embedding_lookup_79602Player2-Embedding/Cast:y:0*
Tindices0*;
_class1
/-loc:@Player2-Embedding/embedding_lookup/79602*+
_output_shapes
:         *
dtype0╫
+Player2-Embedding/embedding_lookup/IdentityIdentity+Player2-Embedding/embedding_lookup:output:0*
T0*;
_class1
/-loc:@Player2-Embedding/embedding_lookup/79602*+
_output_shapes
:         е
-Player2-Embedding/embedding_lookup/Identity_1Identity4Player2-Embedding/embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         i
Player1-Embedding/CastCastinputs_1*

DstT0*

SrcT0*'
_output_shapes
:         Б
"Player1-Embedding/embedding_lookupResourceGather(player1_embedding_embedding_lookup_79608Player1-Embedding/Cast:y:0*
Tindices0*;
_class1
/-loc:@Player1-Embedding/embedding_lookup/79608*+
_output_shapes
:         *
dtype0╫
+Player1-Embedding/embedding_lookup/IdentityIdentity+Player1-Embedding/embedding_lookup:output:0*
T0*;
_class1
/-loc:@Player1-Embedding/embedding_lookup/79608*+
_output_shapes
:         е
-Player1-Embedding/embedding_lookup/Identity_1Identity4Player1-Embedding/embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         `
flatten_2/ConstConst*
_output_shapes
:*
dtype0*
valueB"       а
flatten_2/ReshapeReshape6Player1-Embedding/embedding_lookup/Identity_1:output:0flatten_2/Const:output:0*
T0*'
_output_shapes
:         `
flatten_3/ConstConst*
_output_shapes
:*
dtype0*
valueB"       а
flatten_3/ReshapeReshape6Player2-Embedding/embedding_lookup/Identity_1:output:0flatten_3/Const:output:0*
T0*'
_output_shapes
:         [
concatenate_1/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :┴
concatenate_1/concatConcatV2inputs_0flatten_2/Reshape:output:0flatten_3/Reshape:output:0"concatenate_1/concat/axis:output:0*
N*
T0*'
_output_shapes
:         }Д
dense_3/MatMul/ReadVariableOpReadVariableOp&dense_3_matmul_readvariableop_resource*
_output_shapes

:} *
dtype0Р
dense_3/MatMulMatMulconcatenate_1/concat:output:0%dense_3/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          В
dense_3/BiasAdd/ReadVariableOpReadVariableOp'dense_3_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0О
dense_3/BiasAddBiasAdddense_3/MatMul:product:0&dense_3/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          `
dense_3/ReluReludense_3/BiasAdd:output:0*
T0*'
_output_shapes
:          f
!dense_3/ActivityRegularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    t
dense_3/ActivityRegularizer/AbsAbsdense_3/Relu:activations:0*
T0*'
_output_shapes
:          t
#dense_3/ActivityRegularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ъ
dense_3/ActivityRegularizer/SumSum#dense_3/ActivityRegularizer/Abs:y:0,dense_3/ActivityRegularizer/Const_1:output:0*
T0*
_output_shapes
: f
!dense_3/ActivityRegularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Э
dense_3/ActivityRegularizer/mulMul*dense_3/ActivityRegularizer/mul/x:output:0(dense_3/ActivityRegularizer/Sum:output:0*
T0*
_output_shapes
: Ъ
dense_3/ActivityRegularizer/addAddV2*dense_3/ActivityRegularizer/Const:output:0#dense_3/ActivityRegularizer/mul:z:0*
T0*
_output_shapes
: i
"dense_3/ActivityRegularizer/L2LossL2Lossdense_3/Relu:activations:0*
T0*
_output_shapes
: h
#dense_3/ActivityRegularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4д
!dense_3/ActivityRegularizer/mul_1Mul,dense_3/ActivityRegularizer/mul_1/x:output:0+dense_3/ActivityRegularizer/L2Loss:output:0*
T0*
_output_shapes
: Ч
!dense_3/ActivityRegularizer/add_1AddV2#dense_3/ActivityRegularizer/add:z:0%dense_3/ActivityRegularizer/mul_1:z:0*
T0*
_output_shapes
: k
!dense_3/ActivityRegularizer/ShapeShapedense_3/Relu:activations:0*
T0*
_output_shapes
:y
/dense_3/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_3/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_3/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_3/ActivityRegularizer/strided_sliceStridedSlice*dense_3/ActivityRegularizer/Shape:output:08dense_3/ActivityRegularizer/strided_slice/stack:output:0:dense_3/ActivityRegularizer/strided_slice/stack_1:output:0:dense_3/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_3/ActivityRegularizer/CastCast2dense_3/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: Ь
#dense_3/ActivityRegularizer/truedivRealDiv%dense_3/ActivityRegularizer/add_1:z:0$dense_3/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: \
dropout_2/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *n█6@М
dropout_2/dropout/MulMuldense_3/Relu:activations:0 dropout_2/dropout/Const:output:0*
T0*'
_output_shapes
:          a
dropout_2/dropout/ShapeShapedense_3/Relu:activations:0*
T0*
_output_shapes
:а
.dropout_2/dropout/random_uniform/RandomUniformRandomUniform dropout_2/dropout/Shape:output:0*
T0*'
_output_shapes
:          *
dtype0e
 dropout_2/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *ff&?─
dropout_2/dropout/GreaterEqualGreaterEqual7dropout_2/dropout/random_uniform/RandomUniform:output:0)dropout_2/dropout/GreaterEqual/y:output:0*
T0*'
_output_shapes
:          Г
dropout_2/dropout/CastCast"dropout_2/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*'
_output_shapes
:          З
dropout_2/dropout/Mul_1Muldropout_2/dropout/Mul:z:0dropout_2/dropout/Cast:y:0*
T0*'
_output_shapes
:          Д
dense_4/MatMul/ReadVariableOpReadVariableOp&dense_4_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0О
dense_4/MatMulMatMuldropout_2/dropout/Mul_1:z:0%dense_4/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          В
dense_4/BiasAdd/ReadVariableOpReadVariableOp'dense_4_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0О
dense_4/BiasAddBiasAdddense_4/MatMul:product:0&dense_4/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          `
dense_4/ReluReludense_4/BiasAdd:output:0*
T0*'
_output_shapes
:          f
!dense_4/ActivityRegularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    t
dense_4/ActivityRegularizer/AbsAbsdense_4/Relu:activations:0*
T0*'
_output_shapes
:          t
#dense_4/ActivityRegularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ъ
dense_4/ActivityRegularizer/SumSum#dense_4/ActivityRegularizer/Abs:y:0,dense_4/ActivityRegularizer/Const_1:output:0*
T0*
_output_shapes
: f
!dense_4/ActivityRegularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Э
dense_4/ActivityRegularizer/mulMul*dense_4/ActivityRegularizer/mul/x:output:0(dense_4/ActivityRegularizer/Sum:output:0*
T0*
_output_shapes
: Ъ
dense_4/ActivityRegularizer/addAddV2*dense_4/ActivityRegularizer/Const:output:0#dense_4/ActivityRegularizer/mul:z:0*
T0*
_output_shapes
: i
"dense_4/ActivityRegularizer/L2LossL2Lossdense_4/Relu:activations:0*
T0*
_output_shapes
: h
#dense_4/ActivityRegularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4д
!dense_4/ActivityRegularizer/mul_1Mul,dense_4/ActivityRegularizer/mul_1/x:output:0+dense_4/ActivityRegularizer/L2Loss:output:0*
T0*
_output_shapes
: Ч
!dense_4/ActivityRegularizer/add_1AddV2#dense_4/ActivityRegularizer/add:z:0%dense_4/ActivityRegularizer/mul_1:z:0*
T0*
_output_shapes
: k
!dense_4/ActivityRegularizer/ShapeShapedense_4/Relu:activations:0*
T0*
_output_shapes
:y
/dense_4/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: {
1dense_4/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:{
1dense_4/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:▌
)dense_4/ActivityRegularizer/strided_sliceStridedSlice*dense_4/ActivityRegularizer/Shape:output:08dense_4/ActivityRegularizer/strided_slice/stack:output:0:dense_4/ActivityRegularizer/strided_slice/stack_1:output:0:dense_4/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskМ
 dense_4/ActivityRegularizer/CastCast2dense_4/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: Ь
#dense_4/ActivityRegularizer/truedivRealDiv%dense_4/ActivityRegularizer/add_1:z:0$dense_4/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: \
dropout_3/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *n█6@М
dropout_3/dropout/MulMuldense_4/Relu:activations:0 dropout_3/dropout/Const:output:0*
T0*'
_output_shapes
:          a
dropout_3/dropout/ShapeShapedense_4/Relu:activations:0*
T0*
_output_shapes
:а
.dropout_3/dropout/random_uniform/RandomUniformRandomUniform dropout_3/dropout/Shape:output:0*
T0*'
_output_shapes
:          *
dtype0e
 dropout_3/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *ff&?─
dropout_3/dropout/GreaterEqualGreaterEqual7dropout_3/dropout/random_uniform/RandomUniform:output:0)dropout_3/dropout/GreaterEqual/y:output:0*
T0*'
_output_shapes
:          Г
dropout_3/dropout/CastCast"dropout_3/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*'
_output_shapes
:          З
dropout_3/dropout/Mul_1Muldropout_3/dropout/Mul:z:0dropout_3/dropout/Cast:y:0*
T0*'
_output_shapes
:          Д
dense_5/MatMul/ReadVariableOpReadVariableOp&dense_5_matmul_readvariableop_resource*
_output_shapes

: *
dtype0О
dense_5/MatMulMatMuldropout_3/dropout/Mul_1:z:0%dense_5/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         В
dense_5/BiasAdd/ReadVariableOpReadVariableOp'dense_5_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0О
dense_5/BiasAddBiasAdddense_5/MatMul:product:0&dense_5/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         f
dense_5/SigmoidSigmoiddense_5/BiasAdd:output:0*
T0*'
_output_shapes
:         e
 dense_3/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    Ф
-dense_3/kernel/Regularizer/Abs/ReadVariableOpReadVariableOp&dense_3_matmul_readvariableop_resource*
_output_shapes

:} *
dtype0Е
dense_3/kernel/Regularizer/AbsAbs5dense_3/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:} s
"dense_3/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_3/kernel/Regularizer/SumSum"dense_3/kernel/Regularizer/Abs:y:0+dense_3/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_3/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_3/kernel/Regularizer/mulMul)dense_3/kernel/Regularizer/mul/x:output:0'dense_3/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_3/kernel/Regularizer/addAddV2)dense_3/kernel/Regularizer/Const:output:0"dense_3/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: Ч
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOp&dense_3_matmul_readvariableop_resource*
_output_shapes

:} *
dtype0Ж
!dense_3/kernel/Regularizer/L2LossL2Loss8dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_3/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_3/kernel/Regularizer/mul_1Mul+dense_3/kernel/Regularizer/mul_1/x:output:0*dense_3/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_3/kernel/Regularizer/add_1AddV2"dense_3/kernel/Regularizer/add:z:0$dense_3/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    Ф
-dense_4/kernel/Regularizer/Abs/ReadVariableOpReadVariableOp&dense_4_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0Е
dense_4/kernel/Regularizer/AbsAbs5dense_4/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:  s
"dense_4/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_4/kernel/Regularizer/SumSum"dense_4/kernel/Regularizer/Abs:y:0+dense_4/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_4/kernel/Regularizer/mulMul)dense_4/kernel/Regularizer/mul/x:output:0'dense_4/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_4/kernel/Regularizer/addAddV2)dense_4/kernel/Regularizer/Const:output:0"dense_4/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: Ч
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOp&dense_4_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0Ж
!dense_4/kernel/Regularizer/L2LossL2Loss8dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_4/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_4/kernel/Regularizer/mul_1Mul+dense_4/kernel/Regularizer/mul_1/x:output:0*dense_4/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_4/kernel/Regularizer/add_1AddV2"dense_4/kernel/Regularizer/add:z:0$dense_4/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: b
IdentityIdentitydense_5/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:         g

Identity_1Identity'dense_3/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: g

Identity_2Identity'dense_4/ActivityRegularizer/truediv:z:0^NoOp*
T0*
_output_shapes
: Щ
NoOpNoOp#^Player1-Embedding/embedding_lookup#^Player2-Embedding/embedding_lookup^dense_3/BiasAdd/ReadVariableOp^dense_3/MatMul/ReadVariableOp.^dense_3/kernel/Regularizer/Abs/ReadVariableOp1^dense_3/kernel/Regularizer/L2Loss/ReadVariableOp^dense_4/BiasAdd/ReadVariableOp^dense_4/MatMul/ReadVariableOp.^dense_4/kernel/Regularizer/Abs/ReadVariableOp1^dense_4/kernel/Regularizer/L2Loss/ReadVariableOp^dense_5/BiasAdd/ReadVariableOp^dense_5/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 2H
"Player1-Embedding/embedding_lookup"Player1-Embedding/embedding_lookup2H
"Player2-Embedding/embedding_lookup"Player2-Embedding/embedding_lookup2@
dense_3/BiasAdd/ReadVariableOpdense_3/BiasAdd/ReadVariableOp2>
dense_3/MatMul/ReadVariableOpdense_3/MatMul/ReadVariableOp2^
-dense_3/kernel/Regularizer/Abs/ReadVariableOp-dense_3/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp2@
dense_4/BiasAdd/ReadVariableOpdense_4/BiasAdd/ReadVariableOp2>
dense_4/MatMul/ReadVariableOpdense_4/MatMul/ReadVariableOp2^
-dense_4/kernel/Regularizer/Abs/ReadVariableOp-dense_4/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp2@
dense_5/BiasAdd/ReadVariableOpdense_5/BiasAdd/ReadVariableOp2>
dense_5/MatMul/ReadVariableOpdense_5/MatMul/ReadVariableOp:Q M
'
_output_shapes
:         s
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/2
╫
b
D__inference_dropout_3_layer_call_and_return_conditional_losses_78844

inputs

identity_1N
IdentityIdentityinputs*
T0*'
_output_shapes
:          [

Identity_1IdentityIdentity:output:0*
T0*'
_output_shapes
:          "!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs
Р
╓
B__inference_dense_3_layer_call_and_return_conditional_losses_79836

inputs0
matmul_readvariableop_resource:} -
biasadd_readvariableop_resource: 
identityИвBiasAdd/ReadVariableOpвMatMul/ReadVariableOpв-dense_3/kernel/Regularizer/Abs/ReadVariableOpв0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:} *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
: *
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:          e
 dense_3/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    М
-dense_3/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:} *
dtype0Е
dense_3/kernel/Regularizer/AbsAbs5dense_3/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:} s
"dense_3/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_3/kernel/Regularizer/SumSum"dense_3/kernel/Regularizer/Abs:y:0+dense_3/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_3/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_3/kernel/Regularizer/mulMul)dense_3/kernel/Regularizer/mul/x:output:0'dense_3/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_3/kernel/Regularizer/addAddV2)dense_3/kernel/Regularizer/Const:output:0"dense_3/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: П
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:} *
dtype0Ж
!dense_3/kernel/Regularizer/L2LossL2Loss8dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_3/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_3/kernel/Regularizer/mul_1Mul+dense_3/kernel/Regularizer/mul_1/x:output:0*dense_3/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_3/kernel/Regularizer/add_1AddV2"dense_3/kernel/Regularizer/add:z:0$dense_3/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:          ┌
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp.^dense_3/kernel/Regularizer/Abs/ReadVariableOp1^dense_3/kernel/Regularizer/L2Loss/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         }: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp2^
-dense_3/kernel/Regularizer/Abs/ReadVariableOp-dense_3/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:O K
'
_output_shapes
:         }
 
_user_specified_nameinputs
а
E
)__inference_dropout_3_layer_call_fn_79912

inputs
identity▓
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_3_layer_call_and_return_conditional_losses_78844`
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:          "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs
┴
В
H__inference_concatenate_1_layer_call_and_return_conditional_losses_79792
inputs_0
inputs_1
inputs_2
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :Б
concatConcatV2inputs_0inputs_1inputs_2concat/axis:output:0*
N*
T0*'
_output_shapes
:         }W
IdentityIdentityconcat:output:0*
T0*'
_output_shapes
:         }"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:         s:         :         :Q M
'
_output_shapes
:         s
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/2
о
█
__inference_loss_fn_0_79972H
6dense_3_kernel_regularizer_abs_readvariableop_resource:} 
identityИв-dense_3/kernel/Regularizer/Abs/ReadVariableOpв0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpe
 dense_3/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    д
-dense_3/kernel/Regularizer/Abs/ReadVariableOpReadVariableOp6dense_3_kernel_regularizer_abs_readvariableop_resource*
_output_shapes

:} *
dtype0Е
dense_3/kernel/Regularizer/AbsAbs5dense_3/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:} s
"dense_3/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_3/kernel/Regularizer/SumSum"dense_3/kernel/Regularizer/Abs:y:0+dense_3/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_3/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_3/kernel/Regularizer/mulMul)dense_3/kernel/Regularizer/mul/x:output:0'dense_3/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_3/kernel/Regularizer/addAddV2)dense_3/kernel/Regularizer/Const:output:0"dense_3/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: з
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOp6dense_3_kernel_regularizer_abs_readvariableop_resource*
_output_shapes

:} *
dtype0Ж
!dense_3/kernel/Regularizer/L2LossL2Loss8dense_3/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_3/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_3/kernel/Regularizer/mul_1Mul+dense_3/kernel/Regularizer/mul_1/x:output:0*dense_3/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_3/kernel/Regularizer/add_1AddV2"dense_3/kernel/Regularizer/add:z:0$dense_3/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: b
IdentityIdentity$dense_3/kernel/Regularizer/add_1:z:0^NoOp*
T0*
_output_shapes
: й
NoOpNoOp.^dense_3/kernel/Regularizer/Abs/ReadVariableOp1^dense_3/kernel/Regularizer/L2Loss/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: 2^
-dense_3/kernel/Regularizer/Abs/ReadVariableOp-dense_3/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp0dense_3/kernel/Regularizer/L2Loss/ReadVariableOp
и
E
)__inference_flatten_3_layer_call_fn_79771

inputs
identity▓
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_3_layer_call_and_return_conditional_losses_78744`
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:         "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         :S O
+
_output_shapes
:         
 
_user_specified_nameinputs
╝
▀
#__inference_signature_wrapper_79409
player1_input
player2_input
x_input
unknown:	╧
	unknown_0:	╧
	unknown_1:} 
	unknown_2: 
	unknown_3:  
	unknown_4: 
	unknown_5: 
	unknown_6:
identityИвStatefulPartitionedCallз
StatefulPartitionedCallStatefulPartitionedCallx_inputplayer1_inputplayer2_inputunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         **
_read_only_resource_inputs

	
*0
config_proto 

CPU

GPU2*0J 8В *)
f$R"
 __inference__wrapped_model_78653o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         :         :         s: : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:V R
'
_output_shapes
:         
'
_user_specified_namePlayer1-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer2-Input:PL
'
_output_shapes
:         s
!
_user_specified_name	X-Input
╢
А
H__inference_concatenate_1_layer_call_and_return_conditional_losses_78754

inputs
inputs_1
inputs_2
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :
concatConcatV2inputsinputs_1inputs_2concat/axis:output:0*
N*
T0*'
_output_shapes
:         }W
IdentityIdentityconcat:output:0*
T0*'
_output_shapes
:         }"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:         s:         :         :O K
'
_output_shapes
:         s
 
_user_specified_nameinputs:OK
'
_output_shapes
:         
 
_user_specified_nameinputs:OK
'
_output_shapes
:         
 
_user_specified_nameinputs
╢
Ж
1__inference_Player1-Embedding_layer_call_fn_79728

inputs
unknown:	╧
identityИвStatefulPartitionedCall█
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_78726s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:         `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*(
_input_shapes
:         : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
Ъi
└
 __inference__wrapped_model_78653
x_input
player1_input
player2_inputC
0model_1_player2_embedding_embedding_lookup_78576:	╧C
0model_1_player1_embedding_embedding_lookup_78582:	╧@
.model_1_dense_3_matmul_readvariableop_resource:} =
/model_1_dense_3_biasadd_readvariableop_resource: @
.model_1_dense_4_matmul_readvariableop_resource:  =
/model_1_dense_4_biasadd_readvariableop_resource: @
.model_1_dense_5_matmul_readvariableop_resource: =
/model_1_dense_5_biasadd_readvariableop_resource:
identityИв*model_1/Player1-Embedding/embedding_lookupв*model_1/Player2-Embedding/embedding_lookupв&model_1/dense_3/BiasAdd/ReadVariableOpв%model_1/dense_3/MatMul/ReadVariableOpв&model_1/dense_4/BiasAdd/ReadVariableOpв%model_1/dense_4/MatMul/ReadVariableOpв&model_1/dense_5/BiasAdd/ReadVariableOpв%model_1/dense_5/MatMul/ReadVariableOpv
model_1/Player2-Embedding/CastCastplayer2_input*

DstT0*

SrcT0*'
_output_shapes
:         б
*model_1/Player2-Embedding/embedding_lookupResourceGather0model_1_player2_embedding_embedding_lookup_78576"model_1/Player2-Embedding/Cast:y:0*
Tindices0*C
_class9
75loc:@model_1/Player2-Embedding/embedding_lookup/78576*+
_output_shapes
:         *
dtype0я
3model_1/Player2-Embedding/embedding_lookup/IdentityIdentity3model_1/Player2-Embedding/embedding_lookup:output:0*
T0*C
_class9
75loc:@model_1/Player2-Embedding/embedding_lookup/78576*+
_output_shapes
:         ╡
5model_1/Player2-Embedding/embedding_lookup/Identity_1Identity<model_1/Player2-Embedding/embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         v
model_1/Player1-Embedding/CastCastplayer1_input*

DstT0*

SrcT0*'
_output_shapes
:         б
*model_1/Player1-Embedding/embedding_lookupResourceGather0model_1_player1_embedding_embedding_lookup_78582"model_1/Player1-Embedding/Cast:y:0*
Tindices0*C
_class9
75loc:@model_1/Player1-Embedding/embedding_lookup/78582*+
_output_shapes
:         *
dtype0я
3model_1/Player1-Embedding/embedding_lookup/IdentityIdentity3model_1/Player1-Embedding/embedding_lookup:output:0*
T0*C
_class9
75loc:@model_1/Player1-Embedding/embedding_lookup/78582*+
_output_shapes
:         ╡
5model_1/Player1-Embedding/embedding_lookup/Identity_1Identity<model_1/Player1-Embedding/embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         h
model_1/flatten_2/ConstConst*
_output_shapes
:*
dtype0*
valueB"       ╕
model_1/flatten_2/ReshapeReshape>model_1/Player1-Embedding/embedding_lookup/Identity_1:output:0 model_1/flatten_2/Const:output:0*
T0*'
_output_shapes
:         h
model_1/flatten_3/ConstConst*
_output_shapes
:*
dtype0*
valueB"       ╕
model_1/flatten_3/ReshapeReshape>model_1/Player2-Embedding/embedding_lookup/Identity_1:output:0 model_1/flatten_3/Const:output:0*
T0*'
_output_shapes
:         c
!model_1/concatenate_1/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :р
model_1/concatenate_1/concatConcatV2x_input"model_1/flatten_2/Reshape:output:0"model_1/flatten_3/Reshape:output:0*model_1/concatenate_1/concat/axis:output:0*
N*
T0*'
_output_shapes
:         }Ф
%model_1/dense_3/MatMul/ReadVariableOpReadVariableOp.model_1_dense_3_matmul_readvariableop_resource*
_output_shapes

:} *
dtype0и
model_1/dense_3/MatMulMatMul%model_1/concatenate_1/concat:output:0-model_1/dense_3/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          Т
&model_1/dense_3/BiasAdd/ReadVariableOpReadVariableOp/model_1_dense_3_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0ж
model_1/dense_3/BiasAddBiasAdd model_1/dense_3/MatMul:product:0.model_1/dense_3/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          p
model_1/dense_3/ReluRelu model_1/dense_3/BiasAdd:output:0*
T0*'
_output_shapes
:          n
)model_1/dense_3/ActivityRegularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    Д
'model_1/dense_3/ActivityRegularizer/AbsAbs"model_1/dense_3/Relu:activations:0*
T0*'
_output_shapes
:          |
+model_1/dense_3/ActivityRegularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       ▓
'model_1/dense_3/ActivityRegularizer/SumSum+model_1/dense_3/ActivityRegularizer/Abs:y:04model_1/dense_3/ActivityRegularizer/Const_1:output:0*
T0*
_output_shapes
: n
)model_1/dense_3/ActivityRegularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3╡
'model_1/dense_3/ActivityRegularizer/mulMul2model_1/dense_3/ActivityRegularizer/mul/x:output:00model_1/dense_3/ActivityRegularizer/Sum:output:0*
T0*
_output_shapes
: ▓
'model_1/dense_3/ActivityRegularizer/addAddV22model_1/dense_3/ActivityRegularizer/Const:output:0+model_1/dense_3/ActivityRegularizer/mul:z:0*
T0*
_output_shapes
: y
*model_1/dense_3/ActivityRegularizer/L2LossL2Loss"model_1/dense_3/Relu:activations:0*
T0*
_output_shapes
: p
+model_1/dense_3/ActivityRegularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4╝
)model_1/dense_3/ActivityRegularizer/mul_1Mul4model_1/dense_3/ActivityRegularizer/mul_1/x:output:03model_1/dense_3/ActivityRegularizer/L2Loss:output:0*
T0*
_output_shapes
: п
)model_1/dense_3/ActivityRegularizer/add_1AddV2+model_1/dense_3/ActivityRegularizer/add:z:0-model_1/dense_3/ActivityRegularizer/mul_1:z:0*
T0*
_output_shapes
: {
)model_1/dense_3/ActivityRegularizer/ShapeShape"model_1/dense_3/Relu:activations:0*
T0*
_output_shapes
:Б
7model_1/dense_3/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: Г
9model_1/dense_3/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:Г
9model_1/dense_3/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:Е
1model_1/dense_3/ActivityRegularizer/strided_sliceStridedSlice2model_1/dense_3/ActivityRegularizer/Shape:output:0@model_1/dense_3/ActivityRegularizer/strided_slice/stack:output:0Bmodel_1/dense_3/ActivityRegularizer/strided_slice/stack_1:output:0Bmodel_1/dense_3/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskЬ
(model_1/dense_3/ActivityRegularizer/CastCast:model_1/dense_3/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: ┤
+model_1/dense_3/ActivityRegularizer/truedivRealDiv-model_1/dense_3/ActivityRegularizer/add_1:z:0,model_1/dense_3/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: |
model_1/dropout_2/IdentityIdentity"model_1/dense_3/Relu:activations:0*
T0*'
_output_shapes
:          Ф
%model_1/dense_4/MatMul/ReadVariableOpReadVariableOp.model_1_dense_4_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0ж
model_1/dense_4/MatMulMatMul#model_1/dropout_2/Identity:output:0-model_1/dense_4/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          Т
&model_1/dense_4/BiasAdd/ReadVariableOpReadVariableOp/model_1_dense_4_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0ж
model_1/dense_4/BiasAddBiasAdd model_1/dense_4/MatMul:product:0.model_1/dense_4/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          p
model_1/dense_4/ReluRelu model_1/dense_4/BiasAdd:output:0*
T0*'
_output_shapes
:          n
)model_1/dense_4/ActivityRegularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    Д
'model_1/dense_4/ActivityRegularizer/AbsAbs"model_1/dense_4/Relu:activations:0*
T0*'
_output_shapes
:          |
+model_1/dense_4/ActivityRegularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       ▓
'model_1/dense_4/ActivityRegularizer/SumSum+model_1/dense_4/ActivityRegularizer/Abs:y:04model_1/dense_4/ActivityRegularizer/Const_1:output:0*
T0*
_output_shapes
: n
)model_1/dense_4/ActivityRegularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3╡
'model_1/dense_4/ActivityRegularizer/mulMul2model_1/dense_4/ActivityRegularizer/mul/x:output:00model_1/dense_4/ActivityRegularizer/Sum:output:0*
T0*
_output_shapes
: ▓
'model_1/dense_4/ActivityRegularizer/addAddV22model_1/dense_4/ActivityRegularizer/Const:output:0+model_1/dense_4/ActivityRegularizer/mul:z:0*
T0*
_output_shapes
: y
*model_1/dense_4/ActivityRegularizer/L2LossL2Loss"model_1/dense_4/Relu:activations:0*
T0*
_output_shapes
: p
+model_1/dense_4/ActivityRegularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4╝
)model_1/dense_4/ActivityRegularizer/mul_1Mul4model_1/dense_4/ActivityRegularizer/mul_1/x:output:03model_1/dense_4/ActivityRegularizer/L2Loss:output:0*
T0*
_output_shapes
: п
)model_1/dense_4/ActivityRegularizer/add_1AddV2+model_1/dense_4/ActivityRegularizer/add:z:0-model_1/dense_4/ActivityRegularizer/mul_1:z:0*
T0*
_output_shapes
: {
)model_1/dense_4/ActivityRegularizer/ShapeShape"model_1/dense_4/Relu:activations:0*
T0*
_output_shapes
:Б
7model_1/dense_4/ActivityRegularizer/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: Г
9model_1/dense_4/ActivityRegularizer/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:Г
9model_1/dense_4/ActivityRegularizer/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:Е
1model_1/dense_4/ActivityRegularizer/strided_sliceStridedSlice2model_1/dense_4/ActivityRegularizer/Shape:output:0@model_1/dense_4/ActivityRegularizer/strided_slice/stack:output:0Bmodel_1/dense_4/ActivityRegularizer/strided_slice/stack_1:output:0Bmodel_1/dense_4/ActivityRegularizer/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskЬ
(model_1/dense_4/ActivityRegularizer/CastCast:model_1/dense_4/ActivityRegularizer/strided_slice:output:0*

DstT0*

SrcT0*
_output_shapes
: ┤
+model_1/dense_4/ActivityRegularizer/truedivRealDiv-model_1/dense_4/ActivityRegularizer/add_1:z:0,model_1/dense_4/ActivityRegularizer/Cast:y:0*
T0*
_output_shapes
: |
model_1/dropout_3/IdentityIdentity"model_1/dense_4/Relu:activations:0*
T0*'
_output_shapes
:          Ф
%model_1/dense_5/MatMul/ReadVariableOpReadVariableOp.model_1_dense_5_matmul_readvariableop_resource*
_output_shapes

: *
dtype0ж
model_1/dense_5/MatMulMatMul#model_1/dropout_3/Identity:output:0-model_1/dense_5/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         Т
&model_1/dense_5/BiasAdd/ReadVariableOpReadVariableOp/model_1_dense_5_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0ж
model_1/dense_5/BiasAddBiasAdd model_1/dense_5/MatMul:product:0.model_1/dense_5/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         v
model_1/dense_5/SigmoidSigmoid model_1/dense_5/BiasAdd:output:0*
T0*'
_output_shapes
:         j
IdentityIdentitymodel_1/dense_5/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:         У
NoOpNoOp+^model_1/Player1-Embedding/embedding_lookup+^model_1/Player2-Embedding/embedding_lookup'^model_1/dense_3/BiasAdd/ReadVariableOp&^model_1/dense_3/MatMul/ReadVariableOp'^model_1/dense_4/BiasAdd/ReadVariableOp&^model_1/dense_4/MatMul/ReadVariableOp'^model_1/dense_5/BiasAdd/ReadVariableOp&^model_1/dense_5/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*\
_input_shapesK
I:         s:         :         : : : : : : : : 2X
*model_1/Player1-Embedding/embedding_lookup*model_1/Player1-Embedding/embedding_lookup2X
*model_1/Player2-Embedding/embedding_lookup*model_1/Player2-Embedding/embedding_lookup2P
&model_1/dense_3/BiasAdd/ReadVariableOp&model_1/dense_3/BiasAdd/ReadVariableOp2N
%model_1/dense_3/MatMul/ReadVariableOp%model_1/dense_3/MatMul/ReadVariableOp2P
&model_1/dense_4/BiasAdd/ReadVariableOp&model_1/dense_4/BiasAdd/ReadVariableOp2N
%model_1/dense_4/MatMul/ReadVariableOp%model_1/dense_4/MatMul/ReadVariableOp2P
&model_1/dense_5/BiasAdd/ReadVariableOp&model_1/dense_5/BiasAdd/ReadVariableOp2N
%model_1/dense_5/MatMul/ReadVariableOp%model_1/dense_5/MatMul/ReadVariableOp:P L
'
_output_shapes
:         s
!
_user_specified_name	X-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer1-Input:VR
'
_output_shapes
:         
'
_user_specified_namePlayer2-Input
Є	
c
D__inference_dropout_2_layer_call_and_return_conditional_losses_78988

inputs
identityИR
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *n█6@d
dropout/MulMulinputsdropout/Const:output:0*
T0*'
_output_shapes
:          C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:М
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*'
_output_shapes
:          *
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *ff&?ж
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*'
_output_shapes
:          o
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*'
_output_shapes
:          i
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*'
_output_shapes
:          Y
IdentityIdentitydropout/Mul_1:z:0*
T0*'
_output_shapes
:          "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs
и
E
)__inference_flatten_2_layer_call_fn_79760

inputs
identity▓
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_flatten_2_layer_call_and_return_conditional_losses_78736`
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:         "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         :S O
+
_output_shapes
:         
 
_user_specified_nameinputs
Р
╓
B__inference_dense_4_layer_call_and_return_conditional_losses_78825

inputs0
matmul_readvariableop_resource:  -
biasadd_readvariableop_resource: 
identityИвBiasAdd/ReadVariableOpвMatMul/ReadVariableOpв-dense_4/kernel/Regularizer/Abs/ReadVariableOpв0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:  *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:          r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
: *
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:          P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:          e
 dense_4/kernel/Regularizer/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    М
-dense_4/kernel/Regularizer/Abs/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:  *
dtype0Е
dense_4/kernel/Regularizer/AbsAbs5dense_4/kernel/Regularizer/Abs/ReadVariableOp:value:0*
T0*
_output_shapes

:  s
"dense_4/kernel/Regularizer/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       Ч
dense_4/kernel/Regularizer/SumSum"dense_4/kernel/Regularizer/Abs:y:0+dense_4/kernel/Regularizer/Const_1:output:0*
T0*
_output_shapes
: e
 dense_4/kernel/Regularizer/mul/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐╓3Ъ
dense_4/kernel/Regularizer/mulMul)dense_4/kernel/Regularizer/mul/x:output:0'dense_4/kernel/Regularizer/Sum:output:0*
T0*
_output_shapes
: Ч
dense_4/kernel/Regularizer/addAddV2)dense_4/kernel/Regularizer/Const:output:0"dense_4/kernel/Regularizer/mul:z:0*
T0*
_output_shapes
: П
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:  *
dtype0Ж
!dense_4/kernel/Regularizer/L2LossL2Loss8dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:value:0*
T0*
_output_shapes
: g
"dense_4/kernel/Regularizer/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *Х┐V4б
 dense_4/kernel/Regularizer/mul_1Mul+dense_4/kernel/Regularizer/mul_1/x:output:0*dense_4/kernel/Regularizer/L2Loss:output:0*
T0*
_output_shapes
: Ф
 dense_4/kernel/Regularizer/add_1AddV2"dense_4/kernel/Regularizer/add:z:0$dense_4/kernel/Regularizer/mul_1:z:0*
T0*
_output_shapes
: a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:          ┌
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp.^dense_4/kernel/Regularizer/Abs/ReadVariableOp1^dense_4/kernel/Regularizer/L2Loss/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:          : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp2^
-dense_4/kernel/Regularizer/Abs/ReadVariableOp-dense_4/kernel/Regularizer/Abs/ReadVariableOp2d
0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp0dense_4/kernel/Regularizer/L2Loss/ReadVariableOp:O K
'
_output_shapes
:          
 
_user_specified_nameinputs
╝Е
Э
!__inference__traced_restore_80223
file_prefix@
-assignvariableop_player1_embedding_embeddings:	╧B
/assignvariableop_1_player2_embedding_embeddings:	╧3
!assignvariableop_2_dense_3_kernel:} -
assignvariableop_3_dense_3_bias: 3
!assignvariableop_4_dense_4_kernel:  -
assignvariableop_5_dense_4_bias: 3
!assignvariableop_6_dense_5_kernel: -
assignvariableop_7_dense_5_bias:&
assignvariableop_8_adam_iter:	 (
assignvariableop_9_adam_beta_1: )
assignvariableop_10_adam_beta_2: (
assignvariableop_11_adam_decay: 0
&assignvariableop_12_adam_learning_rate: %
assignvariableop_13_total_1: %
assignvariableop_14_count_1: #
assignvariableop_15_total: #
assignvariableop_16_count: J
7assignvariableop_17_adam_player1_embedding_embeddings_m:	╧J
7assignvariableop_18_adam_player2_embedding_embeddings_m:	╧;
)assignvariableop_19_adam_dense_3_kernel_m:} 5
'assignvariableop_20_adam_dense_3_bias_m: ;
)assignvariableop_21_adam_dense_4_kernel_m:  5
'assignvariableop_22_adam_dense_4_bias_m: ;
)assignvariableop_23_adam_dense_5_kernel_m: 5
'assignvariableop_24_adam_dense_5_bias_m:J
7assignvariableop_25_adam_player1_embedding_embeddings_v:	╧J
7assignvariableop_26_adam_player2_embedding_embeddings_v:	╧;
)assignvariableop_27_adam_dense_3_kernel_v:} 5
'assignvariableop_28_adam_dense_3_bias_v: ;
)assignvariableop_29_adam_dense_4_kernel_v:  5
'assignvariableop_30_adam_dense_4_bias_v: ;
)assignvariableop_31_adam_dense_5_kernel_v: 5
'assignvariableop_32_adam_dense_5_bias_v:
identity_34ИвAssignVariableOpвAssignVariableOp_1вAssignVariableOp_10вAssignVariableOp_11вAssignVariableOp_12вAssignVariableOp_13вAssignVariableOp_14вAssignVariableOp_15вAssignVariableOp_16вAssignVariableOp_17вAssignVariableOp_18вAssignVariableOp_19вAssignVariableOp_2вAssignVariableOp_20вAssignVariableOp_21вAssignVariableOp_22вAssignVariableOp_23вAssignVariableOp_24вAssignVariableOp_25вAssignVariableOp_26вAssignVariableOp_27вAssignVariableOp_28вAssignVariableOp_29вAssignVariableOp_3вAssignVariableOp_30вAssignVariableOp_31вAssignVariableOp_32вAssignVariableOp_4вAssignVariableOp_5вAssignVariableOp_6вAssignVariableOp_7вAssignVariableOp_8вAssignVariableOp_9╨
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:"*
dtype0*Ў
valueьBщ"B:layer_with_weights-0/embeddings/.ATTRIBUTES/VARIABLE_VALUEB:layer_with_weights-1/embeddings/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-3/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-3/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-4/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEBVlayer_with_weights-0/embeddings/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBVlayer_with_weights-1/embeddings/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBVlayer_with_weights-0/embeddings/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBVlayer_with_weights-1/embeddings/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH┤
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:"*
dtype0*W
valueNBL"B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B ╦
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*Ю
_output_shapesЛ
И::::::::::::::::::::::::::::::::::*0
dtypes&
$2"	[
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:Ш
AssignVariableOpAssignVariableOp-assignvariableop_player1_embedding_embeddingsIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:Ю
AssignVariableOp_1AssignVariableOp/assignvariableop_1_player2_embedding_embeddingsIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0*
_output_shapes
:Р
AssignVariableOp_2AssignVariableOp!assignvariableop_2_dense_3_kernelIdentity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:О
AssignVariableOp_3AssignVariableOpassignvariableop_3_dense_3_biasIdentity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:Р
AssignVariableOp_4AssignVariableOp!assignvariableop_4_dense_4_kernelIdentity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_5IdentityRestoreV2:tensors:5"/device:CPU:0*
T0*
_output_shapes
:О
AssignVariableOp_5AssignVariableOpassignvariableop_5_dense_4_biasIdentity_5:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_6IdentityRestoreV2:tensors:6"/device:CPU:0*
T0*
_output_shapes
:Р
AssignVariableOp_6AssignVariableOp!assignvariableop_6_dense_5_kernelIdentity_6:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_7IdentityRestoreV2:tensors:7"/device:CPU:0*
T0*
_output_shapes
:О
AssignVariableOp_7AssignVariableOpassignvariableop_7_dense_5_biasIdentity_7:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_8IdentityRestoreV2:tensors:8"/device:CPU:0*
T0	*
_output_shapes
:Л
AssignVariableOp_8AssignVariableOpassignvariableop_8_adam_iterIdentity_8:output:0"/device:CPU:0*
_output_shapes
 *
dtype0	]

Identity_9IdentityRestoreV2:tensors:9"/device:CPU:0*
T0*
_output_shapes
:Н
AssignVariableOp_9AssignVariableOpassignvariableop_9_adam_beta_1Identity_9:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_10IdentityRestoreV2:tensors:10"/device:CPU:0*
T0*
_output_shapes
:Р
AssignVariableOp_10AssignVariableOpassignvariableop_10_adam_beta_2Identity_10:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_11IdentityRestoreV2:tensors:11"/device:CPU:0*
T0*
_output_shapes
:П
AssignVariableOp_11AssignVariableOpassignvariableop_11_adam_decayIdentity_11:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_12IdentityRestoreV2:tensors:12"/device:CPU:0*
T0*
_output_shapes
:Ч
AssignVariableOp_12AssignVariableOp&assignvariableop_12_adam_learning_rateIdentity_12:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_13IdentityRestoreV2:tensors:13"/device:CPU:0*
T0*
_output_shapes
:М
AssignVariableOp_13AssignVariableOpassignvariableop_13_total_1Identity_13:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_14IdentityRestoreV2:tensors:14"/device:CPU:0*
T0*
_output_shapes
:М
AssignVariableOp_14AssignVariableOpassignvariableop_14_count_1Identity_14:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_15IdentityRestoreV2:tensors:15"/device:CPU:0*
T0*
_output_shapes
:К
AssignVariableOp_15AssignVariableOpassignvariableop_15_totalIdentity_15:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_16IdentityRestoreV2:tensors:16"/device:CPU:0*
T0*
_output_shapes
:К
AssignVariableOp_16AssignVariableOpassignvariableop_16_countIdentity_16:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_17IdentityRestoreV2:tensors:17"/device:CPU:0*
T0*
_output_shapes
:и
AssignVariableOp_17AssignVariableOp7assignvariableop_17_adam_player1_embedding_embeddings_mIdentity_17:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_18IdentityRestoreV2:tensors:18"/device:CPU:0*
T0*
_output_shapes
:и
AssignVariableOp_18AssignVariableOp7assignvariableop_18_adam_player2_embedding_embeddings_mIdentity_18:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_19IdentityRestoreV2:tensors:19"/device:CPU:0*
T0*
_output_shapes
:Ъ
AssignVariableOp_19AssignVariableOp)assignvariableop_19_adam_dense_3_kernel_mIdentity_19:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_20IdentityRestoreV2:tensors:20"/device:CPU:0*
T0*
_output_shapes
:Ш
AssignVariableOp_20AssignVariableOp'assignvariableop_20_adam_dense_3_bias_mIdentity_20:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_21IdentityRestoreV2:tensors:21"/device:CPU:0*
T0*
_output_shapes
:Ъ
AssignVariableOp_21AssignVariableOp)assignvariableop_21_adam_dense_4_kernel_mIdentity_21:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_22IdentityRestoreV2:tensors:22"/device:CPU:0*
T0*
_output_shapes
:Ш
AssignVariableOp_22AssignVariableOp'assignvariableop_22_adam_dense_4_bias_mIdentity_22:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_23IdentityRestoreV2:tensors:23"/device:CPU:0*
T0*
_output_shapes
:Ъ
AssignVariableOp_23AssignVariableOp)assignvariableop_23_adam_dense_5_kernel_mIdentity_23:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_24IdentityRestoreV2:tensors:24"/device:CPU:0*
T0*
_output_shapes
:Ш
AssignVariableOp_24AssignVariableOp'assignvariableop_24_adam_dense_5_bias_mIdentity_24:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_25IdentityRestoreV2:tensors:25"/device:CPU:0*
T0*
_output_shapes
:и
AssignVariableOp_25AssignVariableOp7assignvariableop_25_adam_player1_embedding_embeddings_vIdentity_25:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_26IdentityRestoreV2:tensors:26"/device:CPU:0*
T0*
_output_shapes
:и
AssignVariableOp_26AssignVariableOp7assignvariableop_26_adam_player2_embedding_embeddings_vIdentity_26:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_27IdentityRestoreV2:tensors:27"/device:CPU:0*
T0*
_output_shapes
:Ъ
AssignVariableOp_27AssignVariableOp)assignvariableop_27_adam_dense_3_kernel_vIdentity_27:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_28IdentityRestoreV2:tensors:28"/device:CPU:0*
T0*
_output_shapes
:Ш
AssignVariableOp_28AssignVariableOp'assignvariableop_28_adam_dense_3_bias_vIdentity_28:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_29IdentityRestoreV2:tensors:29"/device:CPU:0*
T0*
_output_shapes
:Ъ
AssignVariableOp_29AssignVariableOp)assignvariableop_29_adam_dense_4_kernel_vIdentity_29:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_30IdentityRestoreV2:tensors:30"/device:CPU:0*
T0*
_output_shapes
:Ш
AssignVariableOp_30AssignVariableOp'assignvariableop_30_adam_dense_4_bias_vIdentity_30:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_31IdentityRestoreV2:tensors:31"/device:CPU:0*
T0*
_output_shapes
:Ъ
AssignVariableOp_31AssignVariableOp)assignvariableop_31_adam_dense_5_kernel_vIdentity_31:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_32IdentityRestoreV2:tensors:32"/device:CPU:0*
T0*
_output_shapes
:Ш
AssignVariableOp_32AssignVariableOp'assignvariableop_32_adam_dense_5_bias_vIdentity_32:output:0"/device:CPU:0*
_output_shapes
 *
dtype01
NoOpNoOp"/device:CPU:0*
_output_shapes
 е
Identity_33Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_29^AssignVariableOp_3^AssignVariableOp_30^AssignVariableOp_31^AssignVariableOp_32^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9^NoOp"/device:CPU:0*
T0*
_output_shapes
: W
Identity_34IdentityIdentity_33:output:0^NoOp_1*
T0*
_output_shapes
: Т
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_29^AssignVariableOp_3^AssignVariableOp_30^AssignVariableOp_31^AssignVariableOp_32^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9*"
_acd_function_control_output(*
_output_shapes
 "#
identity_34Identity_34:output:0*W
_input_shapesF
D: : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_12*
AssignVariableOp_10AssignVariableOp_102*
AssignVariableOp_11AssignVariableOp_112*
AssignVariableOp_12AssignVariableOp_122*
AssignVariableOp_13AssignVariableOp_132*
AssignVariableOp_14AssignVariableOp_142*
AssignVariableOp_15AssignVariableOp_152*
AssignVariableOp_16AssignVariableOp_162*
AssignVariableOp_17AssignVariableOp_172*
AssignVariableOp_18AssignVariableOp_182*
AssignVariableOp_19AssignVariableOp_192(
AssignVariableOp_2AssignVariableOp_22*
AssignVariableOp_20AssignVariableOp_202*
AssignVariableOp_21AssignVariableOp_212*
AssignVariableOp_22AssignVariableOp_222*
AssignVariableOp_23AssignVariableOp_232*
AssignVariableOp_24AssignVariableOp_242*
AssignVariableOp_25AssignVariableOp_252*
AssignVariableOp_26AssignVariableOp_262*
AssignVariableOp_27AssignVariableOp_272*
AssignVariableOp_28AssignVariableOp_282*
AssignVariableOp_29AssignVariableOp_292(
AssignVariableOp_3AssignVariableOp_32*
AssignVariableOp_30AssignVariableOp_302*
AssignVariableOp_31AssignVariableOp_312*
AssignVariableOp_32AssignVariableOp_322(
AssignVariableOp_4AssignVariableOp_42(
AssignVariableOp_5AssignVariableOp_52(
AssignVariableOp_6AssignVariableOp_62(
AssignVariableOp_7AssignVariableOp_72(
AssignVariableOp_8AssignVariableOp_82(
AssignVariableOp_9AssignVariableOp_9:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
╢
Ж
1__inference_Player2-Embedding_layer_call_fn_79745

inputs
unknown:	╧
identityИвStatefulPartitionedCall█
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:         *#
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *U
fPRN
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_78712s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:         `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*(
_input_shapes
:         : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
Є
b
)__inference_dropout_2_layer_call_fn_79846

inputs
identityИвStatefulPartitionedCall┬
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_2_layer_call_and_return_conditional_losses_78988o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:          `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:          
 
_user_specified_nameinputs
╝
`
D__inference_flatten_2_layer_call_and_return_conditional_losses_78736

inputs
identityV
ConstConst*
_output_shapes
:*
dtype0*
valueB"       \
ReshapeReshapeinputsConst:output:0*
T0*'
_output_shapes
:         X
IdentityIdentityReshape:output:0*
T0*'
_output_shapes
:         "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         :S O
+
_output_shapes
:         
 
_user_specified_nameinputs
Х
├
F__inference_dense_3_layer_call_and_return_all_conditional_losses_79812

inputs
unknown:} 
	unknown_0: 
identity

identity_1ИвStatefulPartitionedCall┌
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          *$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8В *K
fFRD
B__inference_dense_3_layer_call_and_return_conditional_losses_78780е
PartitionedCallPartitionedCall StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *7
f2R0
.__inference_dense_3_activity_regularizer_78672o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:          X

Identity_1IdentityPartitionedCall:output:0^NoOp*
T0*
_output_shapes
: `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         }: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:         }
 
_user_specified_nameinputs
╟G
Б
__inference__traced_save_80114
file_prefix;
7savev2_player1_embedding_embeddings_read_readvariableop;
7savev2_player2_embedding_embeddings_read_readvariableop-
)savev2_dense_3_kernel_read_readvariableop+
'savev2_dense_3_bias_read_readvariableop-
)savev2_dense_4_kernel_read_readvariableop+
'savev2_dense_4_bias_read_readvariableop-
)savev2_dense_5_kernel_read_readvariableop+
'savev2_dense_5_bias_read_readvariableop(
$savev2_adam_iter_read_readvariableop	*
&savev2_adam_beta_1_read_readvariableop*
&savev2_adam_beta_2_read_readvariableop)
%savev2_adam_decay_read_readvariableop1
-savev2_adam_learning_rate_read_readvariableop&
"savev2_total_1_read_readvariableop&
"savev2_count_1_read_readvariableop$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableopB
>savev2_adam_player1_embedding_embeddings_m_read_readvariableopB
>savev2_adam_player2_embedding_embeddings_m_read_readvariableop4
0savev2_adam_dense_3_kernel_m_read_readvariableop2
.savev2_adam_dense_3_bias_m_read_readvariableop4
0savev2_adam_dense_4_kernel_m_read_readvariableop2
.savev2_adam_dense_4_bias_m_read_readvariableop4
0savev2_adam_dense_5_kernel_m_read_readvariableop2
.savev2_adam_dense_5_bias_m_read_readvariableopB
>savev2_adam_player1_embedding_embeddings_v_read_readvariableopB
>savev2_adam_player2_embedding_embeddings_v_read_readvariableop4
0savev2_adam_dense_3_kernel_v_read_readvariableop2
.savev2_adam_dense_3_bias_v_read_readvariableop4
0savev2_adam_dense_4_kernel_v_read_readvariableop2
.savev2_adam_dense_4_bias_v_read_readvariableop4
0savev2_adam_dense_5_kernel_v_read_readvariableop2
.savev2_adam_dense_5_bias_v_read_readvariableop
savev2_const

identity_1ИвMergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/partБ
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : У
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: ═
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:"*
dtype0*Ў
valueьBщ"B:layer_with_weights-0/embeddings/.ATTRIBUTES/VARIABLE_VALUEB:layer_with_weights-1/embeddings/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-3/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-3/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-4/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEBVlayer_with_weights-0/embeddings/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBVlayer_with_weights-1/embeddings/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBVlayer_with_weights-0/embeddings/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBVlayer_with_weights-1/embeddings/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH▒
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:"*
dtype0*W
valueNBL"B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B у
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:07savev2_player1_embedding_embeddings_read_readvariableop7savev2_player2_embedding_embeddings_read_readvariableop)savev2_dense_3_kernel_read_readvariableop'savev2_dense_3_bias_read_readvariableop)savev2_dense_4_kernel_read_readvariableop'savev2_dense_4_bias_read_readvariableop)savev2_dense_5_kernel_read_readvariableop'savev2_dense_5_bias_read_readvariableop$savev2_adam_iter_read_readvariableop&savev2_adam_beta_1_read_readvariableop&savev2_adam_beta_2_read_readvariableop%savev2_adam_decay_read_readvariableop-savev2_adam_learning_rate_read_readvariableop"savev2_total_1_read_readvariableop"savev2_count_1_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableop>savev2_adam_player1_embedding_embeddings_m_read_readvariableop>savev2_adam_player2_embedding_embeddings_m_read_readvariableop0savev2_adam_dense_3_kernel_m_read_readvariableop.savev2_adam_dense_3_bias_m_read_readvariableop0savev2_adam_dense_4_kernel_m_read_readvariableop.savev2_adam_dense_4_bias_m_read_readvariableop0savev2_adam_dense_5_kernel_m_read_readvariableop.savev2_adam_dense_5_bias_m_read_readvariableop>savev2_adam_player1_embedding_embeddings_v_read_readvariableop>savev2_adam_player2_embedding_embeddings_v_read_readvariableop0savev2_adam_dense_3_kernel_v_read_readvariableop.savev2_adam_dense_3_bias_v_read_readvariableop0savev2_adam_dense_4_kernel_v_read_readvariableop.savev2_adam_dense_4_bias_v_read_readvariableop0savev2_adam_dense_5_kernel_v_read_readvariableop.savev2_adam_dense_5_bias_v_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *0
dtypes&
$2"	Р
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:Л
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: [
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 "!

identity_1Identity_1:output:0*¤
_input_shapesы
ш: :	╧:	╧:} : :  : : :: : : : : : : : : :	╧:	╧:} : :  : : ::	╧:	╧:} : :  : : :: 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:%!

_output_shapes
:	╧:%!

_output_shapes
:	╧:$ 

_output_shapes

:} : 

_output_shapes
: :$ 

_output_shapes

:  : 

_output_shapes
: :$ 

_output_shapes

: : 

_output_shapes
::	

_output_shapes
: :


_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :%!

_output_shapes
:	╧:%!

_output_shapes
:	╧:$ 

_output_shapes

:} : 

_output_shapes
: :$ 

_output_shapes

:  : 

_output_shapes
: :$ 

_output_shapes

: : 

_output_shapes
::%!

_output_shapes
:	╧:%!

_output_shapes
:	╧:$ 

_output_shapes

:} : 

_output_shapes
: :$ 

_output_shapes

:  : 

_output_shapes
: :$  

_output_shapes

: : !

_output_shapes
::"

_output_shapes
: 
е	
й
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_78726

inputs)
embedding_lookup_78720:	╧
identityИвembedding_lookupU
CastCastinputs*

DstT0*

SrcT0*'
_output_shapes
:         ╣
embedding_lookupResourceGatherembedding_lookup_78720Cast:y:0*
Tindices0*)
_class
loc:@embedding_lookup/78720*+
_output_shapes
:         *
dtype0б
embedding_lookup/IdentityIdentityembedding_lookup:output:0*
T0*)
_class
loc:@embedding_lookup/78720*+
_output_shapes
:         Б
embedding_lookup/Identity_1Identity"embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         w
IdentityIdentity$embedding_lookup/Identity_1:output:0^NoOp*
T0*+
_output_shapes
:         Y
NoOpNoOp^embedding_lookup*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*(
_input_shapes
:         : 2$
embedding_lookupembedding_lookup:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
е	
й
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_79755

inputs)
embedding_lookup_79749:	╧
identityИвembedding_lookupU
CastCastinputs*

DstT0*

SrcT0*'
_output_shapes
:         ╣
embedding_lookupResourceGatherembedding_lookup_79749Cast:y:0*
Tindices0*)
_class
loc:@embedding_lookup/79749*+
_output_shapes
:         *
dtype0б
embedding_lookup/IdentityIdentityembedding_lookup:output:0*
T0*)
_class
loc:@embedding_lookup/79749*+
_output_shapes
:         Б
embedding_lookup/Identity_1Identity"embedding_lookup/Identity:output:0*
T0*+
_output_shapes
:         w
IdentityIdentity$embedding_lookup/Identity_1:output:0^NoOp*
T0*+
_output_shapes
:         Y
NoOpNoOp^embedding_lookup*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*(
_input_shapes
:         : 2$
embedding_lookupembedding_lookup:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
а
E
)__inference_dropout_2_layer_call_fn_79841

inputs
identity▓
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:          * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8В *M
fHRF
D__inference_dropout_2_layer_call_and_return_conditional_losses_78799`
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:          "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:          :O K
'
_output_shapes
:          
 
_user_specified_nameinputs"╡	L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*╝
serving_defaultи
G
Player1-Input6
serving_default_Player1-Input:0         
G
Player2-Input6
serving_default_Player2-Input:0         
;
X-Input0
serving_default_X-Input:0         s;
dense_50
StatefulPartitionedCall:0         tensorflow/serving/predict:йЫ
С
layer-0
layer-1
layer_with_weights-0
layer-2
layer_with_weights-1
layer-3
layer-4
layer-5
layer-6
layer-7
	layer_with_weights-2
	layer-8

layer-9
layer_with_weights-3
layer-10
layer-11
layer_with_weights-4
layer-12
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
_default_save_signature
	optimizer

signatures"
_tf_keras_network
"
_tf_keras_input_layer
"
_tf_keras_input_layer
╡
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses

embeddings"
_tf_keras_layer
╡
	variables
trainable_variables
 regularization_losses
!	keras_api
"__call__
*#&call_and_return_all_conditional_losses
$
embeddings"
_tf_keras_layer
"
_tf_keras_input_layer
е
%	variables
&trainable_variables
'regularization_losses
(	keras_api
)__call__
**&call_and_return_all_conditional_losses"
_tf_keras_layer
е
+	variables
,trainable_variables
-regularization_losses
.	keras_api
/__call__
*0&call_and_return_all_conditional_losses"
_tf_keras_layer
е
1	variables
2trainable_variables
3regularization_losses
4	keras_api
5__call__
*6&call_and_return_all_conditional_losses"
_tf_keras_layer
╗
7	variables
8trainable_variables
9regularization_losses
:	keras_api
;__call__
*<&call_and_return_all_conditional_losses

=kernel
>bias"
_tf_keras_layer
╝
?	variables
@trainable_variables
Aregularization_losses
B	keras_api
C__call__
*D&call_and_return_all_conditional_losses
E_random_generator"
_tf_keras_layer
╗
F	variables
Gtrainable_variables
Hregularization_losses
I	keras_api
J__call__
*K&call_and_return_all_conditional_losses

Lkernel
Mbias"
_tf_keras_layer
╝
N	variables
Otrainable_variables
Pregularization_losses
Q	keras_api
R__call__
*S&call_and_return_all_conditional_losses
T_random_generator"
_tf_keras_layer
╗
U	variables
Vtrainable_variables
Wregularization_losses
X	keras_api
Y__call__
*Z&call_and_return_all_conditional_losses

[kernel
\bias"
_tf_keras_layer
X
0
$1
=2
>3
L4
M5
[6
\7"
trackable_list_wrapper
X
0
$1
=2
>3
L4
M5
[6
\7"
trackable_list_wrapper
.
]0
^1"
trackable_list_wrapper
╩
_non_trainable_variables

`layers
ametrics
blayer_regularization_losses
clayer_metrics
	variables
trainable_variables
regularization_losses
__call__
_default_save_signature
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
╤
dtrace_0
etrace_1
ftrace_2
gtrace_32ц
'__inference_model_1_layer_call_fn_78913
'__inference_model_1_layer_call_fn_79460
'__inference_model_1_layer_call_fn_79485
'__inference_model_1_layer_call_fn_79200┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zdtrace_0zetrace_1zftrace_2zgtrace_3
╜
htrace_0
itrace_1
jtrace_2
ktrace_32╥
B__inference_model_1_layer_call_and_return_conditional_losses_79596
B__inference_model_1_layer_call_and_return_conditional_losses_79721
B__inference_model_1_layer_call_and_return_conditional_losses_79276
B__inference_model_1_layer_call_and_return_conditional_losses_79352┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zhtrace_0zitrace_1zjtrace_2zktrace_3
щBц
 __inference__wrapped_model_78653X-InputPlayer1-InputPlayer2-Input"Ш
С▓Н
FullArgSpec
argsЪ 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
є
liter

mbeta_1

nbeta_2
	odecay
plearning_ratem╤$m╥=m╙>m╘Lm╒Mm╓[m╫\m╪v┘$v┌=v█>v▄Lv▌Mv▐[v▀\vр"
	optimizer
,
qserving_default"
signature_map
'
0"
trackable_list_wrapper
'
0"
trackable_list_wrapper
 "
trackable_list_wrapper
н
rnon_trainable_variables

slayers
tmetrics
ulayer_regularization_losses
vlayer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
ї
wtrace_02╪
1__inference_Player1-Embedding_layer_call_fn_79728в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zwtrace_0
Р
xtrace_02є
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_79738в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zxtrace_0
/:-	╧2Player1-Embedding/embeddings
'
$0"
trackable_list_wrapper
'
$0"
trackable_list_wrapper
 "
trackable_list_wrapper
н
ynon_trainable_variables

zlayers
{metrics
|layer_regularization_losses
}layer_metrics
	variables
trainable_variables
 regularization_losses
"__call__
*#&call_and_return_all_conditional_losses
&#"call_and_return_conditional_losses"
_generic_user_object
ї
~trace_02╪
1__inference_Player2-Embedding_layer_call_fn_79745в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 z~trace_0
Р
trace_02є
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_79755в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 ztrace_0
/:-	╧2Player2-Embedding/embeddings
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
▓
Аnon_trainable_variables
Бlayers
Вmetrics
 Гlayer_regularization_losses
Дlayer_metrics
%	variables
&trainable_variables
'regularization_losses
)__call__
**&call_and_return_all_conditional_losses
&*"call_and_return_conditional_losses"
_generic_user_object
я
Еtrace_02╨
)__inference_flatten_2_layer_call_fn_79760в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zЕtrace_0
К
Жtrace_02ы
D__inference_flatten_2_layer_call_and_return_conditional_losses_79766в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zЖtrace_0
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
▓
Зnon_trainable_variables
Иlayers
Йmetrics
 Кlayer_regularization_losses
Лlayer_metrics
+	variables
,trainable_variables
-regularization_losses
/__call__
*0&call_and_return_all_conditional_losses
&0"call_and_return_conditional_losses"
_generic_user_object
я
Мtrace_02╨
)__inference_flatten_3_layer_call_fn_79771в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zМtrace_0
К
Нtrace_02ы
D__inference_flatten_3_layer_call_and_return_conditional_losses_79777в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zНtrace_0
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
▓
Оnon_trainable_variables
Пlayers
Рmetrics
 Сlayer_regularization_losses
Тlayer_metrics
1	variables
2trainable_variables
3regularization_losses
5__call__
*6&call_and_return_all_conditional_losses
&6"call_and_return_conditional_losses"
_generic_user_object
є
Уtrace_02╘
-__inference_concatenate_1_layer_call_fn_79784в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zУtrace_0
О
Фtrace_02я
H__inference_concatenate_1_layer_call_and_return_conditional_losses_79792в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zФtrace_0
.
=0
>1"
trackable_list_wrapper
.
=0
>1"
trackable_list_wrapper
'
]0"
trackable_list_wrapper
╤
Хnon_trainable_variables
Цlayers
Чmetrics
 Шlayer_regularization_losses
Щlayer_metrics
7	variables
8trainable_variables
9regularization_losses
;__call__
Ъactivity_regularizer_fn
*<&call_and_return_all_conditional_losses
'Ы"call_and_return_conditional_losses"
_generic_user_object
э
Ьtrace_02╬
'__inference_dense_3_layer_call_fn_79801в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zЬtrace_0
М
Эtrace_02э
F__inference_dense_3_layer_call_and_return_all_conditional_losses_79812в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zЭtrace_0
 :} 2dense_3/kernel
: 2dense_3/bias
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
▓
Юnon_trainable_variables
Яlayers
аmetrics
 бlayer_regularization_losses
вlayer_metrics
?	variables
@trainable_variables
Aregularization_losses
C__call__
*D&call_and_return_all_conditional_losses
&D"call_and_return_conditional_losses"
_generic_user_object
╟
гtrace_0
дtrace_12М
)__inference_dropout_2_layer_call_fn_79841
)__inference_dropout_2_layer_call_fn_79846│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zгtrace_0zдtrace_1
¤
еtrace_0
жtrace_12┬
D__inference_dropout_2_layer_call_and_return_conditional_losses_79851
D__inference_dropout_2_layer_call_and_return_conditional_losses_79863│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zеtrace_0zжtrace_1
"
_generic_user_object
.
L0
M1"
trackable_list_wrapper
.
L0
M1"
trackable_list_wrapper
'
^0"
trackable_list_wrapper
╤
зnon_trainable_variables
иlayers
йmetrics
 кlayer_regularization_losses
лlayer_metrics
F	variables
Gtrainable_variables
Hregularization_losses
J__call__
мactivity_regularizer_fn
*K&call_and_return_all_conditional_losses
'н"call_and_return_conditional_losses"
_generic_user_object
э
оtrace_02╬
'__inference_dense_4_layer_call_fn_79872в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zоtrace_0
М
пtrace_02э
F__inference_dense_4_layer_call_and_return_all_conditional_losses_79883в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 zпtrace_0
 :  2dense_4/kernel
: 2dense_4/bias
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
▓
░non_trainable_variables
▒layers
▓metrics
 │layer_regularization_losses
┤layer_metrics
N	variables
Otrainable_variables
Pregularization_losses
R__call__
*S&call_and_return_all_conditional_losses
&S"call_and_return_conditional_losses"
_generic_user_object
╟
╡trace_0
╢trace_12М
)__inference_dropout_3_layer_call_fn_79912
)__inference_dropout_3_layer_call_fn_79917│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 z╡trace_0z╢trace_1
¤
╖trace_0
╕trace_12┬
D__inference_dropout_3_layer_call_and_return_conditional_losses_79922
D__inference_dropout_3_layer_call_and_return_conditional_losses_79934│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 z╖trace_0z╕trace_1
"
_generic_user_object
.
[0
\1"
trackable_list_wrapper
.
[0
\1"
trackable_list_wrapper
 "
trackable_list_wrapper
▓
╣non_trainable_variables
║layers
╗metrics
 ╝layer_regularization_losses
╜layer_metrics
U	variables
Vtrainable_variables
Wregularization_losses
Y__call__
*Z&call_and_return_all_conditional_losses
&Z"call_and_return_conditional_losses"
_generic_user_object
э
╛trace_02╬
'__inference_dense_5_layer_call_fn_79943в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 z╛trace_0
И
┐trace_02щ
B__inference_dense_5_layer_call_and_return_conditional_losses_79954в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 z┐trace_0
 : 2dense_5/kernel
:2dense_5/bias
╬
└trace_02п
__inference_loss_fn_0_79972П
З▓Г
FullArgSpec
argsЪ 
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *в z└trace_0
╬
┴trace_02п
__inference_loss_fn_1_79990П
З▓Г
FullArgSpec
argsЪ 
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *в z┴trace_0
 "
trackable_list_wrapper
~
0
1
2
3
4
5
6
7
	8

9
10
11
12"
trackable_list_wrapper
0
┬0
├1"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
ЧBФ
'__inference_model_1_layer_call_fn_78913X-InputPlayer1-InputPlayer2-Input"┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
ОBЛ
'__inference_model_1_layer_call_fn_79460inputs/0inputs/1inputs/2"┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
ОBЛ
'__inference_model_1_layer_call_fn_79485inputs/0inputs/1inputs/2"┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
ЧBФ
'__inference_model_1_layer_call_fn_79200X-InputPlayer1-InputPlayer2-Input"┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
йBж
B__inference_model_1_layer_call_and_return_conditional_losses_79596inputs/0inputs/1inputs/2"┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
йBж
B__inference_model_1_layer_call_and_return_conditional_losses_79721inputs/0inputs/1inputs/2"┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
▓Bп
B__inference_model_1_layer_call_and_return_conditional_losses_79276X-InputPlayer1-InputPlayer2-Input"┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
▓Bп
B__inference_model_1_layer_call_and_return_conditional_losses_79352X-InputPlayer1-InputPlayer2-Input"┐
╢▓▓
FullArgSpec1
args)Ъ&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaultsЪ
p 

 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
:	 (2	Adam/iter
: (2Adam/beta_1
: (2Adam/beta_2
: (2
Adam/decay
: (2Adam/learning_rate
цBу
#__inference_signature_wrapper_79409Player1-InputPlayer2-InputX-Input"Ф
Н▓Й
FullArgSpec
argsЪ 
varargs
 
varkwjkwargs
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
хBт
1__inference_Player1-Embedding_layer_call_fn_79728inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
АB¤
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_79738inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
хBт
1__inference_Player2-Embedding_layer_call_fn_79745inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
АB¤
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_79755inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
▌B┌
)__inference_flatten_2_layer_call_fn_79760inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
°Bї
D__inference_flatten_2_layer_call_and_return_conditional_losses_79766inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
▌B┌
)__inference_flatten_3_layer_call_fn_79771inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
°Bї
D__inference_flatten_3_layer_call_and_return_conditional_losses_79777inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
ўBЇ
-__inference_concatenate_1_layer_call_fn_79784inputs/0inputs/1inputs/2"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
ТBП
H__inference_concatenate_1_layer_call_and_return_conditional_losses_79792inputs/0inputs/1inputs/2"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
'
]0"
trackable_list_wrapper
 "
trackable_dict_wrapper
√
─trace_02▄
.__inference_dense_3_activity_regularizer_78672й
Ф▓Р
FullArgSpec
argsЪ
jself
jx
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *в
	Кz─trace_0
И
┼trace_02щ
B__inference_dense_3_layer_call_and_return_conditional_losses_79836в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 z┼trace_0
█B╪
'__inference_dense_3_layer_call_fn_79801inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
·Bў
F__inference_dense_3_layer_call_and_return_all_conditional_losses_79812inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
юBы
)__inference_dropout_2_layer_call_fn_79841inputs"│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
юBы
)__inference_dropout_2_layer_call_fn_79846inputs"│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
ЙBЖ
D__inference_dropout_2_layer_call_and_return_conditional_losses_79851inputs"│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
ЙBЖ
D__inference_dropout_2_layer_call_and_return_conditional_losses_79863inputs"│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
'
^0"
trackable_list_wrapper
 "
trackable_dict_wrapper
√
╞trace_02▄
.__inference_dense_4_activity_regularizer_78691й
Ф▓Р
FullArgSpec
argsЪ
jself
jx
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *в
	Кz╞trace_0
И
╟trace_02щ
B__inference_dense_4_layer_call_and_return_conditional_losses_79907в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 z╟trace_0
█B╪
'__inference_dense_4_layer_call_fn_79872inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
·Bў
F__inference_dense_4_layer_call_and_return_all_conditional_losses_79883inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
юBы
)__inference_dropout_3_layer_call_fn_79912inputs"│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
юBы
)__inference_dropout_3_layer_call_fn_79917inputs"│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
ЙBЖ
D__inference_dropout_3_layer_call_and_return_conditional_losses_79922inputs"│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
ЙBЖ
D__inference_dropout_3_layer_call_and_return_conditional_losses_79934inputs"│
к▓ж
FullArgSpec)
args!Ъ
jself
jinputs

jtraining
varargs
 
varkw
 
defaultsЪ
p 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
█B╪
'__inference_dense_5_layer_call_fn_79943inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
ЎBє
B__inference_dense_5_layer_call_and_return_conditional_losses_79954inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
▓Bп
__inference_loss_fn_0_79972"П
З▓Г
FullArgSpec
argsЪ 
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *в 
▓Bп
__inference_loss_fn_1_79990"П
З▓Г
FullArgSpec
argsЪ 
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *в 
R
╚	variables
╔	keras_api

╩total

╦count"
_tf_keras_metric
c
╠	variables
═	keras_api

╬total

╧count
╨
_fn_kwargs"
_tf_keras_metric
фBс
.__inference_dense_3_activity_regularizer_78672x"й
Ф▓Р
FullArgSpec
argsЪ
jself
jx
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *в
	К
ЎBє
B__inference_dense_3_layer_call_and_return_conditional_losses_79836inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
фBс
.__inference_dense_4_activity_regularizer_78691x"й
Ф▓Р
FullArgSpec
argsЪ
jself
jx
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *в
	К
ЎBє
B__inference_dense_4_layer_call_and_return_conditional_losses_79907inputs"в
Щ▓Х
FullArgSpec
argsЪ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsЪ 
kwonlydefaults
 
annotationsк *
 
0
╩0
╦1"
trackable_list_wrapper
.
╚	variables"
_generic_user_object
:  (2total
:  (2count
0
╬0
╧1"
trackable_list_wrapper
.
╠	variables"
_generic_user_object
:  (2total
:  (2count
 "
trackable_dict_wrapper
4:2	╧2#Adam/Player1-Embedding/embeddings/m
4:2	╧2#Adam/Player2-Embedding/embeddings/m
%:#} 2Adam/dense_3/kernel/m
: 2Adam/dense_3/bias/m
%:#  2Adam/dense_4/kernel/m
: 2Adam/dense_4/bias/m
%:# 2Adam/dense_5/kernel/m
:2Adam/dense_5/bias/m
4:2	╧2#Adam/Player1-Embedding/embeddings/v
4:2	╧2#Adam/Player2-Embedding/embeddings/v
%:#} 2Adam/dense_3/kernel/v
: 2Adam/dense_3/bias/v
%:#  2Adam/dense_4/kernel/v
: 2Adam/dense_4/bias/v
%:# 2Adam/dense_5/kernel/v
:2Adam/dense_5/bias/vп
L__inference_Player1-Embedding_layer_call_and_return_conditional_losses_79738_/в,
%в"
 К
inputs         
к ")в&
К
0         
Ъ З
1__inference_Player1-Embedding_layer_call_fn_79728R/в,
%в"
 К
inputs         
к "К         п
L__inference_Player2-Embedding_layer_call_and_return_conditional_losses_79755_$/в,
%в"
 К
inputs         
к ")в&
К
0         
Ъ З
1__inference_Player2-Embedding_layer_call_fn_79745R$/в,
%в"
 К
inputs         
к "К         э
 __inference__wrapped_model_78653╚$=>LM[\ИвД
}вz
xЪu
!К
X-Input         s
'К$
Player1-Input         
'К$
Player2-Input         
к "1к.
,
dense_5!К
dense_5         Ї
H__inference_concatenate_1_layer_call_and_return_conditional_losses_79792з~в{
tвq
oЪl
"К
inputs/0         s
"К
inputs/1         
"К
inputs/2         
к "%в"
К
0         }
Ъ ╠
-__inference_concatenate_1_layer_call_fn_79784Ъ~в{
tвq
oЪl
"К
inputs/0         s
"К
inputs/1         
"К
inputs/2         
к "К         }X
.__inference_dense_3_activity_regularizer_78672&в
в
К	
x
к "К ┤
F__inference_dense_3_layer_call_and_return_all_conditional_losses_79812j=>/в,
%в"
 К
inputs         }
к "3в0
К
0          
Ъ
К	
1/0 в
B__inference_dense_3_layer_call_and_return_conditional_losses_79836\=>/в,
%в"
 К
inputs         }
к "%в"
К
0          
Ъ z
'__inference_dense_3_layer_call_fn_79801O=>/в,
%в"
 К
inputs         }
к "К          X
.__inference_dense_4_activity_regularizer_78691&в
в
К	
x
к "К ┤
F__inference_dense_4_layer_call_and_return_all_conditional_losses_79883jLM/в,
%в"
 К
inputs          
к "3в0
К
0          
Ъ
К	
1/0 в
B__inference_dense_4_layer_call_and_return_conditional_losses_79907\LM/в,
%в"
 К
inputs          
к "%в"
К
0          
Ъ z
'__inference_dense_4_layer_call_fn_79872OLM/в,
%в"
 К
inputs          
к "К          в
B__inference_dense_5_layer_call_and_return_conditional_losses_79954\[\/в,
%в"
 К
inputs          
к "%в"
К
0         
Ъ z
'__inference_dense_5_layer_call_fn_79943O[\/в,
%в"
 К
inputs          
к "К         д
D__inference_dropout_2_layer_call_and_return_conditional_losses_79851\3в0
)в&
 К
inputs          
p 
к "%в"
К
0          
Ъ д
D__inference_dropout_2_layer_call_and_return_conditional_losses_79863\3в0
)в&
 К
inputs          
p
к "%в"
К
0          
Ъ |
)__inference_dropout_2_layer_call_fn_79841O3в0
)в&
 К
inputs          
p 
к "К          |
)__inference_dropout_2_layer_call_fn_79846O3в0
)в&
 К
inputs          
p
к "К          д
D__inference_dropout_3_layer_call_and_return_conditional_losses_79922\3в0
)в&
 К
inputs          
p 
к "%в"
К
0          
Ъ д
D__inference_dropout_3_layer_call_and_return_conditional_losses_79934\3в0
)в&
 К
inputs          
p
к "%в"
К
0          
Ъ |
)__inference_dropout_3_layer_call_fn_79912O3в0
)в&
 К
inputs          
p 
к "К          |
)__inference_dropout_3_layer_call_fn_79917O3в0
)в&
 К
inputs          
p
к "К          д
D__inference_flatten_2_layer_call_and_return_conditional_losses_79766\3в0
)в&
$К!
inputs         
к "%в"
К
0         
Ъ |
)__inference_flatten_2_layer_call_fn_79760O3в0
)в&
$К!
inputs         
к "К         д
D__inference_flatten_3_layer_call_and_return_conditional_losses_79777\3в0
)в&
$К!
inputs         
к "%в"
К
0         
Ъ |
)__inference_flatten_3_layer_call_fn_79771O3в0
)в&
$К!
inputs         
к "К         :
__inference_loss_fn_0_79972=в

в 
к "К :
__inference_loss_fn_1_79990Lв

в 
к "К й
B__inference_model_1_layer_call_and_return_conditional_losses_79276т$=>LM[\ТвО
ЖвВ
xЪu
!К
X-Input         s
'К$
Player1-Input         
'К$
Player2-Input         
p 

 
к "Aв>
К
0         
Ъ
К	
1/0 
К	
1/1 й
B__inference_model_1_layer_call_and_return_conditional_losses_79352т$=>LM[\ТвО
ЖвВ
xЪu
!К
X-Input         s
'К$
Player1-Input         
'К$
Player2-Input         
p

 
к "Aв>
К
0         
Ъ
К	
1/0 
К	
1/1 Ю
B__inference_model_1_layer_call_and_return_conditional_losses_79596╫$=>LM[\ЗвГ
|вy
oЪl
"К
inputs/0         s
"К
inputs/1         
"К
inputs/2         
p 

 
к "Aв>
К
0         
Ъ
К	
1/0 
К	
1/1 Ю
B__inference_model_1_layer_call_and_return_conditional_losses_79721╫$=>LM[\ЗвГ
|вy
oЪl
"К
inputs/0         s
"К
inputs/1         
"К
inputs/2         
p

 
к "Aв>
К
0         
Ъ
К	
1/0 
К	
1/1 х
'__inference_model_1_layer_call_fn_78913╣$=>LM[\ТвО
ЖвВ
xЪu
!К
X-Input         s
'К$
Player1-Input         
'К$
Player2-Input         
p 

 
к "К         х
'__inference_model_1_layer_call_fn_79200╣$=>LM[\ТвО
ЖвВ
xЪu
!К
X-Input         s
'К$
Player1-Input         
'К$
Player2-Input         
p

 
к "К         ┌
'__inference_model_1_layer_call_fn_79460о$=>LM[\ЗвГ
|вy
oЪl
"К
inputs/0         s
"К
inputs/1         
"К
inputs/2         
p 

 
к "К         ┌
'__inference_model_1_layer_call_fn_79485о$=>LM[\ЗвГ
|вy
oЪl
"К
inputs/0         s
"К
inputs/1         
"К
inputs/2         
p

 
к "К         Ъ
#__inference_signature_wrapper_79409Є$=>LM[\▓во
в 
жкв
8
Player1-Input'К$
Player1-Input         
8
Player2-Input'К$
Player2-Input         
,
X-Input!К
X-Input         s"1к.
,
dense_5!К
dense_5         