 class SettingState {
   final List<bool> values;

   SettingState({required this.values});

   SettingState copyWith({
     List<bool>? values,

 }){
     return SettingState(
       values: values??this.values
     );
}

 List<Object?> get props => [values,];
 }

