Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DBBC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 09:26:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 522C6427E8;
	Wed, 18 Jun 2025 11:26:55 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id D8E3440BA4
 for <dev@dpdk.org>; Tue, 17 Jun 2025 16:52:20 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so6338527a12.2
 for <dev@dpdk.org>; Tue, 17 Jun 2025 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750171940; x=1750776740; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AtAvO7b+XPavZYXh3oMXxg517f51y8+rYYZmALmj5go=;
 b=Y39hpzWRZgTWwCx/sn7HdxwWHkN22en7Oil9/5DHKBpyfFTYbawWxHrUMNzOj8J1w+
 IsSDv4UJm8KMNPRTMkq94bHrVRgvisYmrSGEdToM+aociXbOBig13H4KFeEAXFEFYNs0
 bK/vqdDNh4BjueVQ2J0b6rDIr3hvOicKb3WZauZvuQwslVvmkjuJkBm0IFKYNTS6Iabw
 1lCwu2lkKpXODv3FNXoub2jwGEOs+vKmXbT6PniNCA/tWgn4n5rUTrL9y/DREvzS/uHa
 m/bcLzK9QFDI5DcM7hJX7nZMB28z4q+yVcoLEvhlNe5fbFCPLaoEOog7hf20BgpymyvB
 QZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750171940; x=1750776740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtAvO7b+XPavZYXh3oMXxg517f51y8+rYYZmALmj5go=;
 b=amdiHAl9YbVAPRvwcQVET58gZXjP5tfspxKB75JtELiVXcGDBu3ZxWClg4E6p390Rq
 RW98ooKx4UU8WAYMg0Tv8O8JxtCG2cLZTD+sYY3Pi9dTXp4XwH/2eOs+7EyxPapFhd1/
 VuTPhYRR0mrB2S+GSWpCnGcdZwV6o1B9L9IAGHec4Hr082SC/BNeG/jonC2rrr6lK3RC
 440FksWStnW//pYnMlCgUm3lh3lETc/NXfyi1ZTlQNZOAHHSZKAVT/i37kYdkC83jOul
 7Li7MDn4JWRa8InJ816e4QUc46BEUj5f62UFYtJE/G9L3d9ZdE6lkeLtOfIAr0nB6zqh
 D9UA==
X-Gm-Message-State: AOJu0YyBPV2GnNs5T2XMJ69zsYVIXKJ4QIBZy8SCry9EfXw3yd9wZQFi
 Z3quzRbP3jxaq0p+yl0PonM3f8sZWvIdrCzXK4BRw5iUF+sx8EMqn1FDR4K54Lo0zVX9EIft/7b
 gi9INsMzfYOjVZpEaKT9EfnWOfVk0ep/D3HYm
X-Gm-Gg: ASbGncugVojmiMkDHOF55MDzGCmRBo2Q2Fc5T5idJJr7VPHbnsYrsn7ZAbgN488oDv1
 EvFaJXeJXMolU0iY+MMTamOWZPV/AEL/6qClVjfljkNxaT72lcf45YtrBWx8KatvUL2t7pZOU3H
 LMzTNhPU+6Nh3iNtTj8eEZVXAp+zFU1vF2UX7pbmqeU5Zq9JM9ifXDSg==
X-Google-Smtp-Source: AGHT+IGmgZW2vi7d5TqvJCTMKD266SY8j5p71Qhe3p7p05isCo8gn4wGSXtNhT1BzhVuyQy6uTT34LJNMJuv8W23OAQ=
X-Received: by 2002:a05:6a21:e8a:b0:1f5:8f7f:8f19 with SMTP id
 adf61e73a8af0-21fbd569482mr21361514637.10.1750171939826; Tue, 17 Jun 2025
 07:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAM3UhOgt2UmtWhvobLyVzX=gmj46+RrSNGbfKH3fSQ-yhxTw3g@mail.gmail.com>
 <20250608084708.71377b9f@hermes.local>
 <CAM3UhOiMvRu59dMko6RPkWdW4=dyUcetCgLPbOrwUiQxPSXudg@mail.gmail.com>
 <CAM3UhOijhc+EiAxTCgRZsYva9+aTqo_ZTYNf_YpMzyDBM4f4oQ@mail.gmail.com>
In-Reply-To: <CAM3UhOijhc+EiAxTCgRZsYva9+aTqo_ZTYNf_YpMzyDBM4f4oQ@mail.gmail.com>
From: venkatesh bs <venki.bsv@gmail.com>
Date: Tue, 17 Jun 2025 20:22:03 +0530
X-Gm-Features: AX0GCFukEJBLm3ACtQ6AcZHha5JPyhx-PHkH1b7JqJbDCAlrfoiyviwoPboAqL4
Message-ID: <CAM3UhOi3+PvoP48P4GW9izyVH=++mJ2PcTcoVj13CB4jC=NTyQ@mail.gmail.com>
Subject: Re: Question regarding rte_hash_hash and
 rte_hash_add_key_with_hash_data
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c4f25d0637c5a885"
X-Mailman-Approved-At: Wed, 18 Jun 2025 11:26:54 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000c4f25d0637c5a885
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Hi @Stephen Hemminger <stephen@networkplumber.org> ,

We debugged further on this issue ..

We see that position and entry_size(position * key_entry_size) crosses
above int32_t it overflows and it will corrupt random index of hash table.

in Nut shell hash table is only supporting upto 2topower32 size entries on
the table.

Below mentioned snapshot of the code change.

Thanks,
Venkatesh.


struct rte_hash_key *k, *keys =3D h->key_store;
Add comment63Plus  - k =3D (struct rte_hash_key *) ((char *) keys + (positi=
on
+ 1) *
Add comment64Plus  - h->key_entry_size);
Add comment65Plus  + k =3D (struct rte_hash_key *) ((char *) keys +
(uint64_t) (position + 1) *
Add comment66Plus  + (uint64_t) h->key_entry_size);
Add comment67Plus   *key =3D k->key;
Add comment 68


On Mon, Jun 16, 2025 at 9:40=E2=80=AFPM venkatesh bs <venki.bsv@gmail.com> =
wrote:

> Hi @Stephen Hemminger <stephen@networkplumber.org> ,
>
> We debugged further on this issue ..
>
> We see that position and entry_size(position * key_entry_size) crosses
> above int32_t it overflows and it will corrupt random index of hash table=
.
>
> in Nut shell hash table is only supporting upto 2topower32 size entries o=
n
> the table.
>
> Below mentioned snapshot of the code change.
>
> Thanks,
> Venkatesh.
>
>
> struct rte_hash_key *k, *keys =3D h->key_store;
> Add comment63Plus  - k =3D (struct rte_hash_key *) ((char *) keys +
> (position + 1) *
> Add comment64Plus  - h->key_entry_size);
> Add comment65Plus  + k =3D (struct rte_hash_key *) ((char *) keys +
> (uint64_t) (position + 1) *
> Add comment66Plus  + (uint64_t) h->key_entry_size);
> Add comment67Plus   *key =3D k->key;
> Add comment68
>
> On Tue, Jun 10, 2025 at 12:19=E2=80=AFPM venkatesh bs <venki.bsv@gmail.co=
m> wrote:
>
>> Hi @Stephen Hemminger <stephen@networkplumber.org> ,
>>
>> Thanks for the reply , please find the details below.
>>
>> DPDK version : 20.11.6
>>
>> #define LOADBAL_HASH_ENTRIES_MAX (1024*1024*36)
>> #define LOADBAL_HASH_TABLE_SIZE_MULTIPLIER 2
>>
>> hashSizeMultiplier =3D LOADBAL_HASH_TABLE_SIZE_MULTIPLIER;
>>
>>   struct rte_hash_parameters loadbal_hash_params =3D {
>>                   .name =3D NULL,
>>                   .entries =3D LOADBAL_HASH_ENTRIES_MAX *
>> hashSizeMultiplier,
>>                   .key_len =3D sizeof(flow_key_t),
>>                   .hash_func =3D app_hash_crc(internally it calls
>> rte_hash_crc_4byte for v4/v6)
>>                   .hash_func_init_val =3D 0,
>>               };
>>
>> First, what is the return value, which error?
>> we captured only the return value, and will check what  error it is
>> returning.
>>
>> IPv4 Load-Bal Flow hash table:
>>     numInsertions:          998214247
>>     numInsertionsFailures:  4252
>>     numRemovals:            997197485
>>     numRemovalFailures:     214902
>>     numObjects:             1016762
>>     NumBuckets:             75497472
>>     TableCapacity:          75497472
>>     LoadFactor:             1%
>>     NumLookupSuccess:       389165605
>>     NumLookupFails:         2704814006
>>     Failure Analysis:
>>       TableFull(>=3D95%):    0
>>       HighLoad(75-95%):    0
>>       MediumLoad(50-75%):  0
>>       LowLoad(<50%):       4252
>>
>> We are try to analyze the code and find out the details,
>> Initially there will be no issues, insertion starts failing after 24 HRS
>> or so.
>>
>> Thanks,
>> Venkatesh.
>>
>>
>> On Sun, Jun 8, 2025 at 9:17=E2=80=AFPM Stephen Hemminger <
>> stephen@networkplumber.org> wrote:
>>
>>> On Sun, 8 Jun 2025 00:36:02 +0530
>>> venkatesh bs <venki.bsv@gmail.com> wrote:
>>>
>>> > Hi @dpdk community,
>>> >
>>> > In my application, I am using the dpdk hash table as below.
>>> >
>>> > 1. calculate the hash value.
>>> > 2. using this signature add the key and data into  a table.
>>> > 3. lock is used in the 2nd call (add).
>>> >
>>> > Below is the code sniffer for the same.
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> >      hash_sig_t sig =3D rte_hash_hash(hash_tablele, (void *) &new_key=
);
>>> >
>>> >      pthread_mutex_lock(&lock);
>>> >       int32_t ret =3D rte_hash_add_key_with_hash_data(hash_table,
>>> >                           (void *)&new_key,
>>> >                            sig,
>>> >                            info);
>>> >
>>> > if (ret < 0)
>>> > {
>>> >          pthread_mutex_unlock(lock);
>>> >          return TOS_E_FAIL;
>>> > }
>>> > pthread_mutex_unlock(lock);
>>> >
>>> > return OK..
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> >
>>> > My application is having a lot of threads and when run with heavy loa=
d
>>> , I
>>> > am getting a lot of insertion failure, i felt the reason could be
>>> > calculating and adding the has value in 2 api's as opposed to
>>> > rte_hash_add() that is safe under a lock..
>>> >
>>> >
>>> > Please let me know your thoughts.
>>>
>>> Which architecture and DPDK version?
>>> What flags did you use during hash creation?
>>>
>>> As always with open source, the first thing to do is look at the source
>>> and see what is really happening, rather than just relying on the
>>> documentation.
>>>
>>> I assume you are using the default hash function which is CRC.
>>>
>>> First what is the return value, which error?
>>> It might just be key collisions. How big is the table and how many
>>> inserts?
>>>
>>> Also, the current DPDK hash flags with better locking and RCU.
>>> This would be faster than simple pthread mutex.
>>>
>>>

--000000000000c4f25d0637c5a885
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0 Hi=C2=A0<a class=3D"gmail_plusreply" id=3D"m_913989=
8745726590071plusReplyChip-0" href=3D"mailto:stephen@networkplumber.org" ta=
rget=3D"_blank">@Stephen Hemminger</a>=C2=A0,<div><br></div><div>We debugge=
d further on this issue ..</div><div><br></div><div>We see that position=C2=
=A0and entry_size(position * key_entry_size) crosses above int32_t it overf=
lows and it will corrupt random index of hash table.</div><div><br></div><d=
iv>in Nut shell=C2=A0hash table is only supporting upto 2topower32=C2=A0siz=
e entries on the table.=C2=A0</div><div><br></div><div>Below mentioned snap=
shot of the code change.</div><div><br></div><div>Thanks,</div><div>Venkate=
sh.</div><div><br></div><div><br></div><div><div role=3D"row" style=3D"box-=
sizing:inherit;font-family:Menlo,Consolas,&quot;Courier New&quot;,monospace=
;display:table-row;color:rgba(0,0,0,0.9);font-size:12px"><span role=3D"cell=
" style=3D"box-sizing:inherit;padding-right:8px;width:680.969px;display:tab=
le-cell;background-color:rgba(51,153,51,0.1)"> 	struct rte_hash_key *k, *ke=
ys =3D h-&gt;key_store;</span></div><div role=3D"row" style=3D"box-sizing:i=
nherit;font-family:Menlo,Consolas,&quot;Courier New&quot;,monospace;display=
:table-row;color:rgba(0,0,0,0.9);font-size:12px"><span role=3D"cell" style=
=3D"box-sizing:inherit;text-align:center;display:table-cell;min-width:16px;=
min-height:16px"><span id=3D"m_9139898745726590071gmail-m-diff-widget-dpdk-=
uint64-fix2.patch-63" role=3D"button" style=3D"box-sizing:inherit"><span st=
yle=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;=
margin:0px">Add comment</span></span></span><span role=3D"cell" style=3D"bo=
x-sizing:inherit;color:rgba(0,0,0,0.55);text-align:right;padding-left:8px;p=
adding-right:8px;display:table-cell"><span style=3D"box-sizing:inherit;heig=
ht:1px;width:1px;overflow:hidden;padding:0px;margin:0px">63</span><span ari=
a-hidden=3D"true" style=3D"box-sizing:inherit"><span style=3D"box-sizing:in=
herit"></span></span></span><span aria-hidden=3D"true" style=3D"box-sizing:=
inherit;display:table-cell;min-width:20px"></span><span role=3D"cell" style=
=3D"box-sizing:inherit;padding-right:8px;width:680.969px;display:table-cell=
;background-color:rgba(51,153,51,0.1)"><span style=3D"box-sizing:inherit;he=
ight:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=A0=
</span><span aria-hidden=3D"true" style=3D"box-sizing:inherit"><span style=
=3D"box-sizing:inherit"></span></span>-	k =3D (struct rte_hash_key *) ((cha=
r *) keys + (position + 1) *</span></div><div role=3D"row" style=3D"box-siz=
ing:inherit;font-family:Menlo,Consolas,&quot;Courier New&quot;,monospace;di=
splay:table-row;color:rgba(0,0,0,0.9);font-size:12px"><span role=3D"cell" s=
tyle=3D"box-sizing:inherit;text-align:center;display:table-cell;min-width:1=
6px;min-height:16px"><span id=3D"m_9139898745726590071gmail-m-diff-widget-d=
pdk-uint64-fix2.patch-64" role=3D"button" style=3D"box-sizing:inherit"><spa=
n style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:=
0px;margin:0px">Add comment</span></span></span><span role=3D"cell" style=
=3D"box-sizing:inherit;color:rgba(0,0,0,0.55);text-align:right;padding-left=
:8px;padding-right:8px;display:table-cell"><span style=3D"box-sizing:inheri=
t;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">64</span><sp=
an aria-hidden=3D"true" style=3D"box-sizing:inherit"><span style=3D"box-siz=
ing:inherit"></span></span></span><span aria-hidden=3D"true" style=3D"box-s=
izing:inherit;display:table-cell;min-width:20px"></span><span role=3D"cell"=
 style=3D"box-sizing:inherit;padding-right:8px;width:680.969px;display:tabl=
e-cell;background-color:rgba(51,153,51,0.1)"><span style=3D"box-sizing:inhe=
rit;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Plus=C2=A0=
=C2=A0</span><span aria-hidden=3D"true" style=3D"box-sizing:inherit"><span =
style=3D"box-sizing:inherit"></span></span>-				     h-&gt;key_entry_size);=
</span></div><div role=3D"row" style=3D"box-sizing:inherit;font-family:Menl=
o,Consolas,&quot;Courier New&quot;,monospace;display:table-row;color:rgba(0=
,0,0,0.9);font-size:12px"><span role=3D"cell" style=3D"box-sizing:inherit;t=
ext-align:center;display:table-cell;min-width:16px;min-height:16px"><span i=
d=3D"m_9139898745726590071gmail-m-diff-widget-dpdk-uint64-fix2.patch-65" ro=
le=3D"button" style=3D"box-sizing:inherit"><span style=3D"box-sizing:inheri=
t;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Add comment<=
/span></span></span><span role=3D"cell" style=3D"box-sizing:inherit;color:r=
gba(0,0,0,0.55);text-align:right;padding-left:8px;padding-right:8px;display=
:table-cell"><span style=3D"box-sizing:inherit;height:1px;width:1px;overflo=
w:hidden;padding:0px;margin:0px">65</span><span aria-hidden=3D"true" style=
=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit"></span></span></=
span><span aria-hidden=3D"true" style=3D"box-sizing:inherit;display:table-c=
ell;min-width:20px"></span><span role=3D"cell" style=3D"box-sizing:inherit;=
padding-right:8px;width:680.969px;display:table-cell;background-color:rgba(=
51,153,51,0.1)"><span style=3D"box-sizing:inherit;height:1px;width:1px;over=
flow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=A0</span><span aria-hidde=
n=3D"true" style=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit">=
</span></span>+	k =3D (struct rte_hash_key *) ((char *) keys + (uint64_t) (=
position + 1) *</span></div><div role=3D"row" style=3D"box-sizing:inherit;f=
ont-family:Menlo,Consolas,&quot;Courier New&quot;,monospace;display:table-r=
ow;color:rgba(0,0,0,0.9);font-size:12px"><span role=3D"cell" style=3D"box-s=
izing:inherit;text-align:center;display:table-cell;min-width:16px;min-heigh=
t:16px"><span id=3D"m_9139898745726590071gmail-m-diff-widget-dpdk-uint64-fi=
x2.patch-66" role=3D"button" style=3D"box-sizing:inherit"><span style=3D"bo=
x-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;margin:0p=
x">Add comment</span></span></span><span role=3D"cell" style=3D"box-sizing:=
inherit;color:rgba(0,0,0,0.55);text-align:right;padding-left:8px;padding-ri=
ght:8px;display:table-cell"><span style=3D"box-sizing:inherit;height:1px;wi=
dth:1px;overflow:hidden;padding:0px;margin:0px">66</span><span aria-hidden=
=3D"true" style=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit"><=
/span></span></span><span aria-hidden=3D"true" style=3D"box-sizing:inherit;=
display:table-cell;min-width:20px"></span><span role=3D"cell" style=3D"box-=
sizing:inherit;padding-right:8px;width:680.969px;display:table-cell;backgro=
und-color:rgba(51,153,51,0.1)"><span style=3D"box-sizing:inherit;height:1px=
;width:1px;overflow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=A0</span><=
span aria-hidden=3D"true" style=3D"box-sizing:inherit"><span style=3D"box-s=
izing:inherit"></span></span>+				     (uint64_t) h-&gt;key_entry_size);</s=
pan></div><div role=3D"row" style=3D"box-sizing:inherit;font-family:Menlo,C=
onsolas,&quot;Courier New&quot;,monospace;display:table-row;color:rgba(0,0,=
0,0.9);font-size:12px"><span role=3D"cell" style=3D"box-sizing:inherit;text=
-align:center;display:table-cell;min-width:16px;min-height:16px"><span id=
=3D"m_9139898745726590071gmail-m-diff-widget-dpdk-uint64-fix2.patch-67" rol=
e=3D"button" style=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit=
;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Add comment</=
span></span></span><span role=3D"cell" style=3D"box-sizing:inherit;color:rg=
ba(0,0,0,0.55);text-align:right;padding-left:8px;padding-right:8px;display:=
table-cell"><span style=3D"box-sizing:inherit;height:1px;width:1px;overflow=
:hidden;padding:0px;margin:0px">67</span><span aria-hidden=3D"true" style=
=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit"></span></span></=
span><span aria-hidden=3D"true" style=3D"box-sizing:inherit;display:table-c=
ell;min-width:20px"></span><span role=3D"cell" style=3D"box-sizing:inherit;=
padding-right:8px;width:680.969px;display:table-cell;background-color:rgba(=
51,153,51,0.1)"><span style=3D"box-sizing:inherit;height:1px;width:1px;over=
flow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=A0</span><span aria-hidde=
n=3D"true" style=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit">=
</span></span> 	*key =3D k-&gt;key;</span></div><div role=3D"row" style=3D"=
box-sizing:inherit;font-family:Menlo,Consolas,&quot;Courier New&quot;,monos=
pace;display:table-row;color:rgba(0,0,0,0.9);font-size:12px"><span role=3D"=
cell" style=3D"box-sizing:inherit;text-align:center;display:table-cell;min-=
width:16px;min-height:16px"><span id=3D"m_9139898745726590071gmail-m-diff-w=
idget-dpdk-uint64-fix2.patch-68" role=3D"button" style=3D"box-sizing:inheri=
t"><span style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;p=
adding:0px;margin:0px">Add comment
</span></span></span><span role=3D"cell" style=3D"box-sizing:inherit;color:=
rgba(0,0,0,0.55);text-align:right;padding-left:8px;padding-right:8px;displa=
y:table-cell"><span style=3D"box-sizing:inherit;height:1px;width:1px;overfl=
ow:hidden;padding:0px;margin:0px">68</span><div class=3D"gmail-yj6qo gmail-=
ajU" style=3D"outline:none;padding:10px 0px;width:22px;margin:2px 0px 0px">=
<br class=3D"gmail-Apple-interchange-newline">

</div></span></div></div></div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 16, 2025 at 9:40=
=E2=80=AFPM venkatesh bs &lt;<a href=3D"mailto:venki.bsv@gmail.com">venki.b=
sv@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr">Hi=C2=A0<a class=3D"gmail_plusreply" id=3D"m_9=
139898745726590071plusReplyChip-0" href=3D"mailto:stephen@networkplumber.or=
g" target=3D"_blank">@Stephen Hemminger</a>=C2=A0,<div><br></div><div>We de=
bugged further on this issue ..</div><div><br></div><div>We see that positi=
on=C2=A0and entry_size(position * key_entry_size) crosses above int32_t it =
overflows and it will corrupt random index of hash table.</div><div><br></d=
iv><div>in Nut shell=C2=A0hash table is only supporting upto 2topower32=C2=
=A0size entries on the table.=C2=A0</div><div><br></div><div>Below mentione=
d snapshot of the code change.</div><div><br></div><div>Thanks,</div><div>V=
enkatesh.</div><div><br></div><div><br></div><div><div role=3D"row" style=
=3D"box-sizing:inherit;font-family:Menlo,Consolas,&quot;Courier New&quot;,m=
onospace;display:table-row;color:rgba(0,0,0,0.9);font-size:12px;white-space=
:pre-wrap"><span role=3D"cell" style=3D"box-sizing:inherit;padding-right:8p=
x;width:680.969px;display:table-cell;background-color:rgba(51,153,51,0.1)">=
 	struct rte_hash_key *k, *keys =3D h-&gt;key_store;</span></div><div role=
=3D"row" style=3D"box-sizing:inherit;font-family:Menlo,Consolas,&quot;Couri=
er New&quot;,monospace;display:table-row;color:rgba(0,0,0,0.9);font-size:12=
px;white-space:pre-wrap"><span role=3D"cell" style=3D"box-sizing:inherit;te=
xt-align:center;display:table-cell;min-width:16px;min-height:16px"><span id=
=3D"m_9139898745726590071gmail-m-diff-widget-dpdk-uint64-fix2.patch-63" rol=
e=3D"button" style=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit=
;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Add comment</=
span></span></span><span role=3D"cell" style=3D"box-sizing:inherit;color:rg=
ba(0,0,0,0.55);text-align:right;padding-left:8px;padding-right:8px;display:=
table-cell"><span style=3D"box-sizing:inherit;height:1px;width:1px;overflow=
:hidden;padding:0px;margin:0px">63</span><span aria-hidden=3D"true" style=
=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit"></span></span></=
span><span aria-hidden=3D"true" style=3D"box-sizing:inherit;display:table-c=
ell;min-width:20px"></span><span role=3D"cell" style=3D"box-sizing:inherit;=
padding-right:8px;width:680.969px;display:table-cell;background-color:rgba(=
51,153,51,0.1)"><span style=3D"box-sizing:inherit;height:1px;width:1px;over=
flow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=A0</span><span aria-hidde=
n=3D"true" style=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit">=
</span></span>-	k =3D (struct rte_hash_key *) ((char *) keys + (position + =
1) *</span></div><div role=3D"row" style=3D"box-sizing:inherit;font-family:=
Menlo,Consolas,&quot;Courier New&quot;,monospace;display:table-row;color:rg=
ba(0,0,0,0.9);font-size:12px;white-space:pre-wrap"><span role=3D"cell" styl=
e=3D"box-sizing:inherit;text-align:center;display:table-cell;min-width:16px=
;min-height:16px"><span id=3D"m_9139898745726590071gmail-m-diff-widget-dpdk=
-uint64-fix2.patch-64" role=3D"button" style=3D"box-sizing:inherit"><span s=
tyle=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px=
;margin:0px">Add comment</span></span></span><span role=3D"cell" style=3D"b=
ox-sizing:inherit;color:rgba(0,0,0,0.55);text-align:right;padding-left:8px;=
padding-right:8px;display:table-cell"><span style=3D"box-sizing:inherit;hei=
ght:1px;width:1px;overflow:hidden;padding:0px;margin:0px">64</span><span ar=
ia-hidden=3D"true" style=3D"box-sizing:inherit"><span style=3D"box-sizing:i=
nherit"></span></span></span><span aria-hidden=3D"true" style=3D"box-sizing=
:inherit;display:table-cell;min-width:20px"></span><span role=3D"cell" styl=
e=3D"box-sizing:inherit;padding-right:8px;width:680.969px;display:table-cel=
l;background-color:rgba(51,153,51,0.1)"><span style=3D"box-sizing:inherit;h=
eight:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=
=A0</span><span aria-hidden=3D"true" style=3D"box-sizing:inherit"><span sty=
le=3D"box-sizing:inherit"></span></span>-				     h-&gt;key_entry_size);</s=
pan></div><div role=3D"row" style=3D"box-sizing:inherit;font-family:Menlo,C=
onsolas,&quot;Courier New&quot;,monospace;display:table-row;color:rgba(0,0,=
0,0.9);font-size:12px;white-space:pre-wrap"><span role=3D"cell" style=3D"bo=
x-sizing:inherit;text-align:center;display:table-cell;min-width:16px;min-he=
ight:16px"><span id=3D"m_9139898745726590071gmail-m-diff-widget-dpdk-uint64=
-fix2.patch-65" role=3D"button" style=3D"box-sizing:inherit"><span style=3D=
"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;margin=
:0px">Add comment</span></span></span><span role=3D"cell" style=3D"box-sizi=
ng:inherit;color:rgba(0,0,0,0.55);text-align:right;padding-left:8px;padding=
-right:8px;display:table-cell"><span style=3D"box-sizing:inherit;height:1px=
;width:1px;overflow:hidden;padding:0px;margin:0px">65</span><span aria-hidd=
en=3D"true" style=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit"=
></span></span></span><span aria-hidden=3D"true" style=3D"box-sizing:inheri=
t;display:table-cell;min-width:20px"></span><span role=3D"cell" style=3D"bo=
x-sizing:inherit;padding-right:8px;width:680.969px;display:table-cell;backg=
round-color:rgba(51,153,51,0.1)"><span style=3D"box-sizing:inherit;height:1=
px;width:1px;overflow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=A0</span=
><span aria-hidden=3D"true" style=3D"box-sizing:inherit"><span style=3D"box=
-sizing:inherit"></span></span>+	k =3D (struct rte_hash_key *) ((char *) ke=
ys + (uint64_t) (position + 1) *</span></div><div role=3D"row" style=3D"box=
-sizing:inherit;font-family:Menlo,Consolas,&quot;Courier New&quot;,monospac=
e;display:table-row;color:rgba(0,0,0,0.9);font-size:12px;white-space:pre-wr=
ap"><span role=3D"cell" style=3D"box-sizing:inherit;text-align:center;displ=
ay:table-cell;min-width:16px;min-height:16px"><span id=3D"m_913989874572659=
0071gmail-m-diff-widget-dpdk-uint64-fix2.patch-66" role=3D"button" style=3D=
"box-sizing:inherit"><span style=3D"box-sizing:inherit;height:1px;width:1px=
;overflow:hidden;padding:0px;margin:0px">Add comment</span></span></span><s=
pan role=3D"cell" style=3D"box-sizing:inherit;color:rgba(0,0,0,0.55);text-a=
lign:right;padding-left:8px;padding-right:8px;display:table-cell"><span sty=
le=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;m=
argin:0px">66</span><span aria-hidden=3D"true" style=3D"box-sizing:inherit"=
><span style=3D"box-sizing:inherit"></span></span></span><span aria-hidden=
=3D"true" style=3D"box-sizing:inherit;display:table-cell;min-width:20px"></=
span><span role=3D"cell" style=3D"box-sizing:inherit;padding-right:8px;widt=
h:680.969px;display:table-cell;background-color:rgba(51,153,51,0.1)"><span =
style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0p=
x;margin:0px">Plus=C2=A0=C2=A0</span><span aria-hidden=3D"true" style=3D"bo=
x-sizing:inherit"><span style=3D"box-sizing:inherit"></span></span>+				   =
  (uint64_t) h-&gt;key_entry_size);</span></div><div role=3D"row" style=3D"=
box-sizing:inherit;font-family:Menlo,Consolas,&quot;Courier New&quot;,monos=
pace;display:table-row;color:rgba(0,0,0,0.9);font-size:12px;white-space:pre=
-wrap"><span role=3D"cell" style=3D"box-sizing:inherit;text-align:center;di=
splay:table-cell;min-width:16px;min-height:16px"><span id=3D"m_913989874572=
6590071gmail-m-diff-widget-dpdk-uint64-fix2.patch-67" role=3D"button" style=
=3D"box-sizing:inherit"><span style=3D"box-sizing:inherit;height:1px;width:=
1px;overflow:hidden;padding:0px;margin:0px">Add comment</span></span></span=
><span role=3D"cell" style=3D"box-sizing:inherit;color:rgba(0,0,0,0.55);tex=
t-align:right;padding-left:8px;padding-right:8px;display:table-cell"><span =
style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0p=
x;margin:0px">67</span><span aria-hidden=3D"true" style=3D"box-sizing:inher=
it"><span style=3D"box-sizing:inherit"></span></span></span><span aria-hidd=
en=3D"true" style=3D"box-sizing:inherit;display:table-cell;min-width:20px">=
</span><span role=3D"cell" style=3D"box-sizing:inherit;padding-right:8px;wi=
dth:680.969px;display:table-cell;background-color:rgba(51,153,51,0.1)"><spa=
n style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:=
0px;margin:0px">Plus=C2=A0=C2=A0</span><span aria-hidden=3D"true" style=3D"=
box-sizing:inherit"><span style=3D"box-sizing:inherit"></span></span> 	*key=
 =3D k-&gt;key;</span></div><div role=3D"row" style=3D"box-sizing:inherit;f=
ont-family:Menlo,Consolas,&quot;Courier New&quot;,monospace;display:table-r=
ow;color:rgba(0,0,0,0.9);font-size:12px;white-space:pre-wrap"><span role=3D=
"cell" style=3D"box-sizing:inherit;text-align:center;display:table-cell;min=
-width:16px;min-height:16px"><span id=3D"m_9139898745726590071gmail-m-diff-=
widget-dpdk-uint64-fix2.patch-68" role=3D"button" style=3D"box-sizing:inher=
it"><span style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;=
padding:0px;margin:0px">Add comment</span></span></span><span role=3D"cell"=
 style=3D"box-sizing:inherit;color:rgba(0,0,0,0.55);text-align:right;paddin=
g-left:8px;padding-right:8px;display:table-cell"><span style=3D"box-sizing:=
inherit;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">68</sp=
an><span aria-hidden=3D"true" style=3D"box-sizing:inherit"><span style=3D"b=
ox-sizing:inherit"></span></span></span><span aria-hidden=3D"true" style=3D=
"box-sizing:inherit;display:table-cell;min-width:20px"></span><span role=3D=
"cell" style=3D"box-sizing:inherit;padding-right:8px;width:680.969px;displa=
y:table-cell;background-color:rgba(51,153,51,0.1)">

</span></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Tue, Jun 10, 2025 at 12:19=E2=80=AFPM venkatesh bs &l=
t;<a href=3D"mailto:venki.bsv@gmail.com" target=3D"_blank">venki.bsv@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0<a class=3D"gmail_plusreply" i=
d=3D"m_9139898745726590071m_2940332444406401942gmail-plusReplyChip-0" href=
=3D"mailto:stephen@networkplumber.org" target=3D"_blank">@Stephen Hemminger=
</a>=C2=A0,<div><br></div><div>Thanks for the reply , please find the detai=
ls below.</div><div><br></div><div>DPDK version : 20.11.6</div><div><br>#de=
fine LOADBAL_HASH_ENTRIES_MAX (1024*1024*36)<br>#define LOADBAL_HASH_TABLE_=
SIZE_MULTIPLIER 2<br><br>hashSizeMultiplier =3D LOADBAL_HASH_TABLE_SIZE_MUL=
TIPLIER;<br><br>=C2=A0 struct rte_hash_parameters loadbal_hash_params =3D {=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =
=3D NULL,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 .entries =3D LOADBAL_HASH_ENTRIES_MAX * hashSizeMultiplier,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .key_len =3D sizeof(fl=
ow_key_t),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .hash_func =3D app_hash_crc(internally it calls rte_hash_crc_4byte for =
v4/v6)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .h=
ash_func_init_val =3D 0,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 };<br><br>First, what is the return value, which error?<br>	we captured=
 only the return value, and will check what =C2=A0error it is returning.<br=
><br>IPv4 Load-Bal Flow hash table:<br>=C2=A0 =C2=A0 numInsertions: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0998214247<br>=C2=A0 =C2=A0 numInsertionsFailures=
: =C2=A04252<br>=C2=A0 =C2=A0 numRemovals: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0997197485<br>=C2=A0 =C2=A0 numRemovalFailures: =C2=A0 =C2=A0 2149=
02<br>=C2=A0 =C2=A0 numObjects: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1=
016762<br>=C2=A0 =C2=A0 NumBuckets: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 75497472<br>=C2=A0 =C2=A0 TableCapacity: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A075497472<br>=C2=A0 =C2=A0 LoadFactor: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 1%<br>=C2=A0 =C2=A0 NumLookupSuccess: =C2=A0 =C2=A0 =C2=A0 38916=
5605<br>=C2=A0 =C2=A0 NumLookupFails: =C2=A0 =C2=A0 =C2=A0 =C2=A0 270481400=
6<br>=C2=A0 =C2=A0 Failure Analysis:<br>=C2=A0 =C2=A0 =C2=A0 TableFull(&gt;=
=3D95%): =C2=A0 =C2=A00<br>=C2=A0 =C2=A0 =C2=A0 HighLoad(75-95%): =C2=A0 =
=C2=A00<br>=C2=A0 =C2=A0 =C2=A0 MediumLoad(50-75%): =C2=A00<br>=C2=A0 =C2=
=A0 =C2=A0 LowLoad(&lt;50%): =C2=A0 =C2=A0 =C2=A0 4252<br>=C2=A0 =C2=A0</di=
v></div>We are try to analyze the code and find out=C2=A0the details,<div>I=
nitially there will be no issues, insertion starts failing after 24 HRS or =
so.</div><div><br></div><div>Thanks,</div><div>Venkatesh.</div><div><br><di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On S=
un, Jun 8, 2025 at 9:17=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:=
stephen@networkplumber.org" target=3D"_blank">stephen@networkplumber.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Sun, 8 Jun 2025 00:36:02 +0530<br>
venkatesh bs &lt;<a href=3D"mailto:venki.bsv@gmail.com" target=3D"_blank">v=
enki.bsv@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Hi @dpdk community,<br>
&gt; <br>
&gt; In my application, I am using the dpdk hash table as below.<br>
&gt; <br>
&gt; 1. calculate the hash value.<br>
&gt; 2. using this signature add the key and data into=C2=A0 a table.<br>
&gt; 3. lock is used in the 2nd call (add).<br>
&gt; <br>
&gt; Below is the code sniffer for the same.<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hash_sig_t sig =3D rte_hash_hash(hash_tablele, (vo=
id *) &amp;new_key);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 pthread_mutex_lock(&amp;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int32_t ret =3D rte_hash_add_key_with_hash_d=
ata(hash_table,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;new_key,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sig,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 info);<br>
&gt; <br>
&gt; if (ret &lt; 0)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TOS_E_FAIL;<br>
&gt; }<br>
&gt; pthread_mutex_unlock(lock);<br>
&gt; <br>
&gt; return OK..<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; My application is having a lot of threads and when run with heavy load=
 , I<br>
&gt; am getting a lot of insertion failure, i felt the reason could be<br>
&gt; calculating and adding the has value in 2 api&#39;s as opposed to<br>
&gt; rte_hash_add() that is safe under a lock..<br>
&gt; <br>
&gt; <br>
&gt; Please let me know your thoughts.<br>
<br>
Which architecture and DPDK version?<br>
What flags did you use during hash creation?<br>
<br>
As always with open source, the first thing to do is look at the source<br>
and see what is really happening, rather than just relying on the documenta=
tion.<br>
<br>
I assume you are using the default hash function which is CRC.<br>
<br>
First what is the return value, which error?<br>
It might just be key collisions. How big is the table and how many inserts?=
<br>
<br>
Also, the current DPDK hash flags with better locking and RCU.<br>
This would be faster than simple pthread mutex.<br>
<br>
</blockquote></div></div></div></div>
</blockquote></div>
</blockquote></div>

--000000000000c4f25d0637c5a885--
