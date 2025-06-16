Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4FBC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 11:56:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E07F40E2E;
	Tue, 17 Jun 2025 13:56:55 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 35A6D4021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 18:11:14 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-742c73f82dfso3629043b3a.2
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750090273; x=1750695073; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0KDudeCLmYkLQg1jV5Q9Nt13uY35asDORNXX8yje3gE=;
 b=WwCmT8WJjMqWMl4j2MFr3fnvJzCT2nX8LUAlxV0gMzRVbfu8tQVNlBItMf5ufsc7zx
 erzqB125ciVed7MetbB8pN2SVdB4wtlr2YkZMpej+FxrR3UaBP1gGAbDEha9F50HXeWT
 2Q1RlZx1b5n0x+rKoqsrcSmdrw7bWC9GyAZt+/S97akeVK8GnAju8/lehSETUvGCXtoT
 NoSX7n5rdReBqft+bztG+M2LNRdQvSw3xbo5mw1ni6McXaDt7qN0F0WH6Htq+w7TvqQz
 ktq9jRtPbbjuGDPoXuU8opw0YqyjrfddFypIFmTv2ezd07rv8S23m22iZ7+ccBjMmtJ4
 Qmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090273; x=1750695073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0KDudeCLmYkLQg1jV5Q9Nt13uY35asDORNXX8yje3gE=;
 b=B0o3cFbqDVfDdpaKv0a97etUAlZ+ivWjReAajwc+CVGBcQZcVsVQx7ZMYgxaEG+gfU
 YpbFKQovnfhsSfglLxZNCUVxPunYQYITXsxdagMRCACFF8vsSWOgaqhySmCOTY2T9fyn
 nY7QpZZuzP5RxiQKaBOjbqsOrL3xgMrvNqpeaa4MYWApux1b3vavGAl6mVqGQI4NvJsZ
 93M1nIuTeBYRr/a1EGUeBCyi0k7eQK7zpIgpAW+cDnHyPiIaMUkjL5xLfPNBs0KzroFh
 9Pmcmwh73UamAADDWXjJGMARU6/1FN9vvadRTXwoSX9oDhBb8oF/LzApQmLycUQMQC8g
 sCww==
X-Gm-Message-State: AOJu0Yz1LBIUvA4nzzBPMOI+sp80pYVA8AS1ra07v8HpKK80SNHjj3No
 lj5vAsGsnm/MaIHzCQGzp2qz4P9/lZJdjt0ruWLl471E+bxIDaCx3wrsuavJYm2hwTg7uO+XnUR
 hcLV1kTPjVeeshBy8prWbPPdpyQSWB8o=
X-Gm-Gg: ASbGnctbmXYP2HzWzn3e9DHh2Vm8OOXy7m7fBEFOuSv6GcUUM+3DMF4Ef31GgMmjdRW
 xnifYWbScUumdP8M7Lnxe6TmuMmY+vkIcOFwB7gjauP5H0j97fVuW1KGaigHtHaJLKFsXLsKiQF
 /R9xcmGavWxtjwDhl4DkoOQ3ybfTMygjdv+NQ7m0nj2h6rsvwc/60sllVyUOKiceuqOxMWcrIsB
 tUNApubg+BUEJqJ
X-Google-Smtp-Source: AGHT+IFnJmMOHin2FHT9j7LH0c2nkyP0pv3QhEjBtjc3Qs1nvVcxKcEaKuBzLlT3BMHMArx3I7raPiZe6MHenHqP71I=
X-Received: by 2002:a05:6a00:1c8c:b0:748:9d26:bb0a with SMTP id
 d2e1a72fcca58-7489d26c2a3mr13467761b3a.18.1750090273148; Mon, 16 Jun 2025
 09:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAM3UhOgt2UmtWhvobLyVzX=gmj46+RrSNGbfKH3fSQ-yhxTw3g@mail.gmail.com>
 <20250608084708.71377b9f@hermes.local>
 <CAM3UhOiMvRu59dMko6RPkWdW4=dyUcetCgLPbOrwUiQxPSXudg@mail.gmail.com>
In-Reply-To: <CAM3UhOiMvRu59dMko6RPkWdW4=dyUcetCgLPbOrwUiQxPSXudg@mail.gmail.com>
From: venkatesh bs <venki.bsv@gmail.com>
Date: Mon, 16 Jun 2025 21:40:59 +0530
X-Gm-Features: AX0GCFv0yQa3iDhbpQWccqu2fcfG51lUj8EqZvDsBT_6ib9nFvQroJ-OHADYI1w
Message-ID: <CAM3UhOijhc+EiAxTCgRZsYva9+aTqo_ZTYNf_YpMzyDBM4f4oQ@mail.gmail.com>
Subject: Re: Question regarding rte_hash_hash and
 rte_hash_add_key_with_hash_data
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000000e51ed0637b2a5ba"
X-Mailman-Approved-At: Tue, 17 Jun 2025 13:56:54 +0200
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

--0000000000000e51ed0637b2a5ba
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
Add comment68

On Tue, Jun 10, 2025 at 12:19=E2=80=AFPM venkatesh bs <venki.bsv@gmail.com>=
 wrote:

> Hi @Stephen Hemminger <stephen@networkplumber.org> ,
>
> Thanks for the reply , please find the details below.
>
> DPDK version : 20.11.6
>
> #define LOADBAL_HASH_ENTRIES_MAX (1024*1024*36)
> #define LOADBAL_HASH_TABLE_SIZE_MULTIPLIER 2
>
> hashSizeMultiplier =3D LOADBAL_HASH_TABLE_SIZE_MULTIPLIER;
>
>   struct rte_hash_parameters loadbal_hash_params =3D {
>                   .name =3D NULL,
>                   .entries =3D LOADBAL_HASH_ENTRIES_MAX * hashSizeMultipl=
ier,
>                   .key_len =3D sizeof(flow_key_t),
>                   .hash_func =3D app_hash_crc(internally it calls
> rte_hash_crc_4byte for v4/v6)
>                   .hash_func_init_val =3D 0,
>               };
>
> First, what is the return value, which error?
> we captured only the return value, and will check what  error it is
> returning.
>
> IPv4 Load-Bal Flow hash table:
>     numInsertions:          998214247
>     numInsertionsFailures:  4252
>     numRemovals:            997197485
>     numRemovalFailures:     214902
>     numObjects:             1016762
>     NumBuckets:             75497472
>     TableCapacity:          75497472
>     LoadFactor:             1%
>     NumLookupSuccess:       389165605
>     NumLookupFails:         2704814006
>     Failure Analysis:
>       TableFull(>=3D95%):    0
>       HighLoad(75-95%):    0
>       MediumLoad(50-75%):  0
>       LowLoad(<50%):       4252
>
> We are try to analyze the code and find out the details,
> Initially there will be no issues, insertion starts failing after 24 HRS
> or so.
>
> Thanks,
> Venkatesh.
>
>
> On Sun, Jun 8, 2025 at 9:17=E2=80=AFPM Stephen Hemminger <
> stephen@networkplumber.org> wrote:
>
>> On Sun, 8 Jun 2025 00:36:02 +0530
>> venkatesh bs <venki.bsv@gmail.com> wrote:
>>
>> > Hi @dpdk community,
>> >
>> > In my application, I am using the dpdk hash table as below.
>> >
>> > 1. calculate the hash value.
>> > 2. using this signature add the key and data into  a table.
>> > 3. lock is used in the 2nd call (add).
>> >
>> > Below is the code sniffer for the same.
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >      hash_sig_t sig =3D rte_hash_hash(hash_tablele, (void *) &new_key)=
;
>> >
>> >      pthread_mutex_lock(&lock);
>> >       int32_t ret =3D rte_hash_add_key_with_hash_data(hash_table,
>> >                           (void *)&new_key,
>> >                            sig,
>> >                            info);
>> >
>> > if (ret < 0)
>> > {
>> >          pthread_mutex_unlock(lock);
>> >          return TOS_E_FAIL;
>> > }
>> > pthread_mutex_unlock(lock);
>> >
>> > return OK..
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > My application is having a lot of threads and when run with heavy load
>> , I
>> > am getting a lot of insertion failure, i felt the reason could be
>> > calculating and adding the has value in 2 api's as opposed to
>> > rte_hash_add() that is safe under a lock..
>> >
>> >
>> > Please let me know your thoughts.
>>
>> Which architecture and DPDK version?
>> What flags did you use during hash creation?
>>
>> As always with open source, the first thing to do is look at the source
>> and see what is really happening, rather than just relying on the
>> documentation.
>>
>> I assume you are using the default hash function which is CRC.
>>
>> First what is the return value, which error?
>> It might just be key collisions. How big is the table and how many
>> inserts?
>>
>> Also, the current DPDK hash flags with better locking and RCU.
>> This would be faster than simple pthread mutex.
>>
>>

--0000000000000e51ed0637b2a5ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0<a class=3D"gmail_plusreply" id=3D"plusReplyChip-0=
" href=3D"mailto:stephen@networkplumber.org" tabindex=3D"-1">@Stephen Hemmi=
nger</a>=C2=A0,<div><br></div><div>We debugged further on this issue ..</di=
v><div><br></div><div>We see that position=C2=A0and entry_size(position * k=
ey_entry_size) crosses above int32_t it overflows and it will corrupt rando=
m index of hash table.</div><div><br></div><div>in Nut shell=C2=A0hash tabl=
e is only supporting upto 2topower32=C2=A0size entries on the table.=C2=A0<=
/div><div><br></div><div>Below mentioned snapshot of the code change.</div>=
<div><br></div><div>Thanks,</div><div>Venkatesh.</div><div><br></div><div><=
br></div><div><div class=3D"gmail-repos-diff-contents-row gmail-monospaced-=
text" role=3D"row" style=3D"box-sizing:inherit;font-family:Menlo,Consolas,&=
quot;Courier New&quot;,monospace;display:table-row;color:rgba(0,0,0,0.9);fo=
nt-size:12px;white-space:pre"><span tabindex=3D"-1" class=3D"gmail-padding-=
right-8 gmail-repos-line-content gmail-added" role=3D"cell" style=3D"box-si=
zing:inherit;padding-right:8px;width:680.969px;display:table-cell;backgroun=
d-color:rgba(51,153,51,0.1)"> 	struct rte_hash_key *k, *keys =3D h-&gt;key_=
store;</span></div><div class=3D"gmail-repos-diff-contents-row gmail-monosp=
aced-text" role=3D"row" style=3D"box-sizing:inherit;font-family:Menlo,Conso=
las,&quot;Courier New&quot;,monospace;display:table-row;color:rgba(0,0,0,0.=
9);font-size:12px;white-space:pre"><span role=3D"cell" class=3D"gmail-repos=
-add-comment-widget gmail-text-center" style=3D"box-sizing:inherit;text-ali=
gn:center;display:table-cell;min-width:16px;min-height:16px"><span id=3D"gm=
ail-m-diff-widget-dpdk-uint64-fix2.patch-63" tabindex=3D"0" role=3D"button"=
 style=3D"box-sizing:inherit"><span class=3D"gmail-screen-reader-only" styl=
e=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;ma=
rgin:0px">Add comment</span></span></span><span role=3D"cell" class=3D"gmai=
l-padding-horizontal-8 gmail-text-right gmail-secondary-text" style=3D"box-=
sizing:inherit;color:rgba(0,0,0,0.55);text-align:right;padding-left:8px;pad=
ding-right:8px;display:table-cell"><span class=3D"gmail-screen-reader-only"=
 style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0=
px;margin:0px">63</span><span aria-hidden=3D"true" style=3D"box-sizing:inhe=
rit"><span class=3D"gmail-repos-line-number" style=3D"box-sizing:inherit"><=
/span></span></span><span aria-hidden=3D"true" class=3D"gmail-repos-collaps=
ed-comment" style=3D"box-sizing:inherit;display:table-cell;min-width:20px">=
</span><span tabindex=3D"-1" class=3D"gmail-padding-right-8 gmail-repos-lin=
e-content gmail-added" role=3D"cell" style=3D"box-sizing:inherit;padding-ri=
ght:8px;width:680.969px;display:table-cell;background-color:rgba(51,153,51,=
0.1)"><span class=3D"gmail-screen-reader-only" style=3D"box-sizing:inherit;=
height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=
=A0</span><span aria-hidden=3D"true" style=3D"box-sizing:inherit"><span cla=
ss=3D"gmail-line-icon gmail-added" style=3D"box-sizing:inherit"></span></sp=
an>-	k =3D (struct rte_hash_key *) ((char *) keys + (position + 1) *</span>=
</div><div class=3D"gmail-repos-diff-contents-row gmail-monospaced-text" ro=
le=3D"row" style=3D"box-sizing:inherit;font-family:Menlo,Consolas,&quot;Cou=
rier New&quot;,monospace;display:table-row;color:rgba(0,0,0,0.9);font-size:=
12px;white-space:pre"><span role=3D"cell" class=3D"gmail-repos-add-comment-=
widget gmail-text-center" style=3D"box-sizing:inherit;text-align:center;dis=
play:table-cell;min-width:16px;min-height:16px"><span id=3D"gmail-m-diff-wi=
dget-dpdk-uint64-fix2.patch-64" tabindex=3D"0" role=3D"button" style=3D"box=
-sizing:inherit"><span class=3D"gmail-screen-reader-only" style=3D"box-sizi=
ng:inherit;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Add=
 comment</span></span></span><span role=3D"cell" class=3D"gmail-padding-hor=
izontal-8 gmail-text-right gmail-secondary-text" style=3D"box-sizing:inheri=
t;color:rgba(0,0,0,0.55);text-align:right;padding-left:8px;padding-right:8p=
x;display:table-cell"><span class=3D"gmail-screen-reader-only" style=3D"box=
-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px=
">64</span><span aria-hidden=3D"true" style=3D"box-sizing:inherit"><span cl=
ass=3D"gmail-repos-line-number" style=3D"box-sizing:inherit"></span></span>=
</span><span aria-hidden=3D"true" class=3D"gmail-repos-collapsed-comment" s=
tyle=3D"box-sizing:inherit;display:table-cell;min-width:20px"></span><span =
tabindex=3D"-1" class=3D"gmail-padding-right-8 gmail-repos-line-content gma=
il-added" role=3D"cell" style=3D"box-sizing:inherit;padding-right:8px;width=
:680.969px;display:table-cell;background-color:rgba(51,153,51,0.1)"><span c=
lass=3D"gmail-screen-reader-only" style=3D"box-sizing:inherit;height:1px;wi=
dth:1px;overflow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=A0</span><spa=
n aria-hidden=3D"true" style=3D"box-sizing:inherit"><span class=3D"gmail-li=
ne-icon gmail-added" style=3D"box-sizing:inherit"></span></span>-				     h=
-&gt;key_entry_size);</span></div><div class=3D"gmail-repos-diff-contents-r=
ow gmail-monospaced-text" role=3D"row" style=3D"box-sizing:inherit;font-fam=
ily:Menlo,Consolas,&quot;Courier New&quot;,monospace;display:table-row;colo=
r:rgba(0,0,0,0.9);font-size:12px;white-space:pre"><span role=3D"cell" class=
=3D"gmail-repos-add-comment-widget gmail-text-center" style=3D"box-sizing:i=
nherit;text-align:center;display:table-cell;min-width:16px;min-height:16px"=
><span id=3D"gmail-m-diff-widget-dpdk-uint64-fix2.patch-65" tabindex=3D"0" =
role=3D"button" style=3D"box-sizing:inherit"><span class=3D"gmail-screen-re=
ader-only" style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden=
;padding:0px;margin:0px">Add comment</span></span></span><span role=3D"cell=
" class=3D"gmail-padding-horizontal-8 gmail-text-right gmail-secondary-text=
" style=3D"box-sizing:inherit;color:rgba(0,0,0,0.55);text-align:right;paddi=
ng-left:8px;padding-right:8px;display:table-cell"><span class=3D"gmail-scre=
en-reader-only" style=3D"box-sizing:inherit;height:1px;width:1px;overflow:h=
idden;padding:0px;margin:0px">65</span><span aria-hidden=3D"true" style=3D"=
box-sizing:inherit"><span class=3D"gmail-repos-line-number" style=3D"box-si=
zing:inherit"></span></span></span><span aria-hidden=3D"true" class=3D"gmai=
l-repos-collapsed-comment" style=3D"box-sizing:inherit;display:table-cell;m=
in-width:20px"></span><span tabindex=3D"-1" class=3D"gmail-padding-right-8 =
gmail-repos-line-content gmail-added" role=3D"cell" style=3D"box-sizing:inh=
erit;padding-right:8px;width:680.969px;display:table-cell;background-color:=
rgba(51,153,51,0.1)"><span class=3D"gmail-screen-reader-only" style=3D"box-=
sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px"=
>Plus=C2=A0=C2=A0</span><span aria-hidden=3D"true" style=3D"box-sizing:inhe=
rit"><span class=3D"gmail-line-icon gmail-added" style=3D"box-sizing:inheri=
t"></span></span>+	k =3D (struct rte_hash_key *) ((char *) keys + (uint64_t=
) (position + 1) *</span></div><div class=3D"gmail-repos-diff-contents-row =
gmail-monospaced-text" role=3D"row" style=3D"box-sizing:inherit;font-family=
:Menlo,Consolas,&quot;Courier New&quot;,monospace;display:table-row;color:r=
gba(0,0,0,0.9);font-size:12px;white-space:pre"><span role=3D"cell" class=3D=
"gmail-repos-add-comment-widget gmail-text-center" style=3D"box-sizing:inhe=
rit;text-align:center;display:table-cell;min-width:16px;min-height:16px"><s=
pan id=3D"gmail-m-diff-widget-dpdk-uint64-fix2.patch-66" tabindex=3D"0" rol=
e=3D"button" style=3D"box-sizing:inherit"><span class=3D"gmail-screen-reade=
r-only" style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;pa=
dding:0px;margin:0px">Add comment</span></span></span><span role=3D"cell" c=
lass=3D"gmail-padding-horizontal-8 gmail-text-right gmail-secondary-text" s=
tyle=3D"box-sizing:inherit;color:rgba(0,0,0,0.55);text-align:right;padding-=
left:8px;padding-right:8px;display:table-cell"><span class=3D"gmail-screen-=
reader-only" style=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidd=
en;padding:0px;margin:0px">66</span><span aria-hidden=3D"true" style=3D"box=
-sizing:inherit"><span class=3D"gmail-repos-line-number" style=3D"box-sizin=
g:inherit"></span></span></span><span aria-hidden=3D"true" class=3D"gmail-r=
epos-collapsed-comment" style=3D"box-sizing:inherit;display:table-cell;min-=
width:20px"></span><span tabindex=3D"-1" class=3D"gmail-padding-right-8 gma=
il-repos-line-content gmail-added" role=3D"cell" style=3D"box-sizing:inheri=
t;padding-right:8px;width:680.969px;display:table-cell;background-color:rgb=
a(51,153,51,0.1)"><span class=3D"gmail-screen-reader-only" style=3D"box-siz=
ing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Pl=
us=C2=A0=C2=A0</span><span aria-hidden=3D"true" style=3D"box-sizing:inherit=
"><span class=3D"gmail-line-icon gmail-added" style=3D"box-sizing:inherit">=
</span></span>+				     (uint64_t) h-&gt;key_entry_size);</span></div><div =
class=3D"gmail-repos-diff-contents-row gmail-monospaced-text" role=3D"row" =
style=3D"box-sizing:inherit;font-family:Menlo,Consolas,&quot;Courier New&qu=
ot;,monospace;display:table-row;color:rgba(0,0,0,0.9);font-size:12px;white-=
space:pre"><span role=3D"cell" class=3D"gmail-repos-add-comment-widget gmai=
l-text-center" style=3D"box-sizing:inherit;text-align:center;display:table-=
cell;min-width:16px;min-height:16px"><span id=3D"gmail-m-diff-widget-dpdk-u=
int64-fix2.patch-67" tabindex=3D"0" role=3D"button" style=3D"box-sizing:inh=
erit"><span class=3D"gmail-screen-reader-only" style=3D"box-sizing:inherit;=
height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">Add comment</s=
pan></span></span><span role=3D"cell" class=3D"gmail-padding-horizontal-8 g=
mail-text-right gmail-secondary-text" style=3D"box-sizing:inherit;color:rgb=
a(0,0,0,0.55);text-align:right;padding-left:8px;padding-right:8px;display:t=
able-cell"><span class=3D"gmail-screen-reader-only" style=3D"box-sizing:inh=
erit;height:1px;width:1px;overflow:hidden;padding:0px;margin:0px">67</span>=
<span aria-hidden=3D"true" style=3D"box-sizing:inherit"><span class=3D"gmai=
l-repos-line-number" style=3D"box-sizing:inherit"></span></span></span><spa=
n aria-hidden=3D"true" class=3D"gmail-repos-collapsed-comment" style=3D"box=
-sizing:inherit;display:table-cell;min-width:20px"></span><span tabindex=3D=
"-1" class=3D"gmail-padding-right-8 gmail-repos-line-content gmail-added" r=
ole=3D"cell" style=3D"box-sizing:inherit;padding-right:8px;width:680.969px;=
display:table-cell;background-color:rgba(51,153,51,0.1)"><span class=3D"gma=
il-screen-reader-only" style=3D"box-sizing:inherit;height:1px;width:1px;ove=
rflow:hidden;padding:0px;margin:0px">Plus=C2=A0=C2=A0</span><span aria-hidd=
en=3D"true" style=3D"box-sizing:inherit"><span class=3D"gmail-line-icon gma=
il-added" style=3D"box-sizing:inherit"></span></span> 	*key =3D k-&gt;key;<=
/span></div><div class=3D"gmail-repos-diff-contents-row gmail-monospaced-te=
xt" role=3D"row" style=3D"box-sizing:inherit;font-family:Menlo,Consolas,&qu=
ot;Courier New&quot;,monospace;display:table-row;color:rgba(0,0,0,0.9);font=
-size:12px;white-space:pre"><span role=3D"cell" class=3D"gmail-repos-add-co=
mment-widget gmail-text-center" style=3D"box-sizing:inherit;text-align:cent=
er;display:table-cell;min-width:16px;min-height:16px"><span id=3D"gmail-m-d=
iff-widget-dpdk-uint64-fix2.patch-68" tabindex=3D"0" role=3D"button" style=
=3D"box-sizing:inherit"><span class=3D"gmail-screen-reader-only" style=3D"b=
ox-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;margin:0=
px">Add comment</span></span></span><span role=3D"cell" class=3D"gmail-padd=
ing-horizontal-8 gmail-text-right gmail-secondary-text" style=3D"box-sizing=
:inherit;color:rgba(0,0,0,0.55);text-align:right;padding-left:8px;padding-r=
ight:8px;display:table-cell"><span class=3D"gmail-screen-reader-only" style=
=3D"box-sizing:inherit;height:1px;width:1px;overflow:hidden;padding:0px;mar=
gin:0px">68</span><span aria-hidden=3D"true" style=3D"box-sizing:inherit"><=
span class=3D"gmail-repos-line-number" style=3D"box-sizing:inherit"></span>=
</span></span><span aria-hidden=3D"true" class=3D"gmail-repos-collapsed-com=
ment" style=3D"box-sizing:inherit;display:table-cell;min-width:20px"></span=
><span tabindex=3D"-1" class=3D"gmail-padding-right-8 gmail-repos-line-cont=
ent gmail-added" role=3D"cell" style=3D"box-sizing:inherit;padding-right:8p=
x;width:680.969px;display:table-cell;background-color:rgba(51,153,51,0.1)">

</span></div></div></div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 10, 2025 at 12:19=E2=
=80=AFPM venkatesh bs &lt;<a href=3D"mailto:venki.bsv@gmail.com">venki.bsv@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0<a class=3D"gmail_plus=
reply" id=3D"m_2940332444406401942gmail-plusReplyChip-0" href=3D"mailto:ste=
phen@networkplumber.org" target=3D"_blank">@Stephen Hemminger</a>=C2=A0,<di=
v><br></div><div>Thanks for the reply , please find the details below.</div=
><div><br></div><div>DPDK version : 20.11.6</div><div><br>#define LOADBAL_H=
ASH_ENTRIES_MAX (1024*1024*36)<br>#define LOADBAL_HASH_TABLE_SIZE_MULTIPLIE=
R 2<br><br>hashSizeMultiplier =3D LOADBAL_HASH_TABLE_SIZE_MULTIPLIER;<br><b=
r>=C2=A0 struct rte_hash_parameters loadbal_hash_params =3D {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D NULL,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .entries =3D LO=
ADBAL_HASH_ENTRIES_MAX * hashSizeMultiplier,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .key_len =3D sizeof(flow_key_t),<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .hash_func =3D =
app_hash_crc(internally it calls rte_hash_crc_4byte for v4/v6)<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .hash_func_init_val=
 =3D 0,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br><br>First=
, what is the return value, which error?<br>	we captured only the return va=
lue, and will check what =C2=A0error it is returning.<br><br>IPv4 Load-Bal =
Flow hash table:<br>=C2=A0 =C2=A0 numInsertions: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0998214247<br>=C2=A0 =C2=A0 numInsertionsFailures: =C2=A04252<br>=
=C2=A0 =C2=A0 numRemovals: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09971974=
85<br>=C2=A0 =C2=A0 numRemovalFailures: =C2=A0 =C2=A0 214902<br>=C2=A0 =C2=
=A0 numObjects: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1016762<br>=C2=A0=
 =C2=A0 NumBuckets: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 75497472<br>=
=C2=A0 =C2=A0 TableCapacity: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A075497472<br>=
=C2=A0 =C2=A0 LoadFactor: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1%<br>=
=C2=A0 =C2=A0 NumLookupSuccess: =C2=A0 =C2=A0 =C2=A0 389165605<br>=C2=A0 =
=C2=A0 NumLookupFails: =C2=A0 =C2=A0 =C2=A0 =C2=A0 2704814006<br>=C2=A0 =C2=
=A0 Failure Analysis:<br>=C2=A0 =C2=A0 =C2=A0 TableFull(&gt;=3D95%): =C2=A0=
 =C2=A00<br>=C2=A0 =C2=A0 =C2=A0 HighLoad(75-95%): =C2=A0 =C2=A00<br>=C2=A0=
 =C2=A0 =C2=A0 MediumLoad(50-75%): =C2=A00<br>=C2=A0 =C2=A0 =C2=A0 LowLoad(=
&lt;50%): =C2=A0 =C2=A0 =C2=A0 4252<br>=C2=A0 =C2=A0</div></div>We are try =
to analyze the code and find out=C2=A0the details,<div>Initially there will=
 be no issues, insertion starts failing after 24 HRS or so.</div><div><br><=
/div><div>Thanks,</div><div>Venkatesh.</div><div><br><div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jun 8, 2025 at =
9:17=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplum=
ber.org" target=3D"_blank">stephen@networkplumber.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Sun, 8 Jun 2025 00:=
36:02 +0530<br>
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

--0000000000000e51ed0637b2a5ba--
