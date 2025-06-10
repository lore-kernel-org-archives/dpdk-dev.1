Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F60DC5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B67D342DDF;
	Tue, 10 Jun 2025 08:57:41 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 2EA9042DD0
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:49:19 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3122368d7c4so4057752a91.1
 for <dev@dpdk.org>; Mon, 09 Jun 2025 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749538158; x=1750142958; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ywig23b+d3faeoM2c3j/xdLjGgcBzfxb/3QbCNvS7Zg=;
 b=ghPKBdIwpiWTYPFvmksWSdwloWj2GQ891bem+r+PF6qVqdLwbWOLhvxvidrWZkDJvr
 UcMduPlPjeMuOtPaIU0f7iDElXmj2Qp+/xhIW1tr6g71hqHcKq0ER3eznnj10oEeUOE0
 jdpqE9CPwwYHus0neoF8JDH9OmSXd+Bcha9y8LYfIl3EC4qGW6L4MRA8cHiA7+JzWXVC
 1eqCc7uqUtVts37z1yZ7jc43PAAg10FVRVfdiUQ3IvTca++6dTjlJyS/qzzJx1syfb6Y
 dAXVok8SMtCfOyYrT74HuGzDtn1AkKCb3f+5U//vVrveqB7WOr6ld5PI/CPCykWIaS31
 5MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749538158; x=1750142958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ywig23b+d3faeoM2c3j/xdLjGgcBzfxb/3QbCNvS7Zg=;
 b=MgInUorkoi8UcfhoWeDynyVAjIN1uVpYVDCs9dFzrzkE1SN9yTGE6Ix+iCdHjoTGFk
 s5em+A11gH+ygcSd0hJAvzkiiSwWBO4/EtuS5riu1z9XndvDD2MTla9XEp4tw37n1Gda
 kusHNdgHzo69y7VumuKzpVP0SP3DkiOePHRR+CVzW1ukMAz41eQMDHYmEDc7GGZnZWf+
 GooEutRr8ab27FcooTFGlustL1mPowjvQQ+aP75rpF2PQX2B/MRrnp17j63Nj4nPHvTM
 OpT1ENd67jrrMjrGZDTe64tJr6dE5y6vyWZFw44BjPIcUQHnX+cS77kVHz+O3ojXXhVj
 hQ4g==
X-Gm-Message-State: AOJu0YxG6vsoYZzvc8mr9R0T5m4/k0oHy9zeh3qVHQP8yURBzgFfknaW
 /zbmlIhdxSzNtC8IYBmbJnIYkGLHA160e0A8HnYhrV004NT0Kk3ErUIpzihxuB7+1B8DMaJIjSI
 zV7qHFvWfseCzUxbEyrhlC87eJtp5djt2BNLS
X-Gm-Gg: ASbGncs7xQG+/rXucQUJ9h9qLl/XMnbueW9fv0L1DYOQSoU0MfH4OJf69f5RBq4ADGa
 VlkbjEEuqGWb4zZBQTi2bIQ8Fc1k0htEirFhCtYYE0edV0hSQr17L3w9L/rX+Gsi5Bn2BYaCnn7
 siitI7mE1ZI33A3/HPq3/w3GD9Lxbt1r9P7eYFjnntQuk=
X-Google-Smtp-Source: AGHT+IG/KQqUaLzjxqljPjeythLdJtCCC5BP8CEyxWnciDDhk71V7NLNPfFI/lKxbp9aKQ1JKcn4DcQ6dVI2s1p9oEs=
X-Received: by 2002:a17:90b:264c:b0:313:2f45:2fc8 with SMTP id
 98e67ed59e1d1-3134740a056mr24457368a91.18.1749538158279; Mon, 09 Jun 2025
 23:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAM3UhOgt2UmtWhvobLyVzX=gmj46+RrSNGbfKH3fSQ-yhxTw3g@mail.gmail.com>
 <20250608084708.71377b9f@hermes.local>
In-Reply-To: <20250608084708.71377b9f@hermes.local>
From: venkatesh bs <venki.bsv@gmail.com>
Date: Tue, 10 Jun 2025 12:19:06 +0530
X-Gm-Features: AX0GCFu7e5SvItmNcXhG83X4-h-k1lrsYqXwJX3S3qASAVu3_HKqF3qR72t2br0
Message-ID: <CAM3UhOiMvRu59dMko6RPkWdW4=dyUcetCgLPbOrwUiQxPSXudg@mail.gmail.com>
Subject: Re: Question regarding rte_hash_hash and
 rte_hash_add_key_with_hash_data
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000007202ea0637321814"
X-Mailman-Approved-At: Tue, 10 Jun 2025 08:57:39 +0200
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

--0000000000007202ea0637321814
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Stephen Hemminger <stephen@networkplumber.org> ,

Thanks for the reply , please find the details below.

DPDK version : 20.11.6

#define LOADBAL_HASH_ENTRIES_MAX (1024*1024*36)
#define LOADBAL_HASH_TABLE_SIZE_MULTIPLIER 2

hashSizeMultiplier =3D LOADBAL_HASH_TABLE_SIZE_MULTIPLIER;

  struct rte_hash_parameters loadbal_hash_params =3D {
                  .name =3D NULL,
                  .entries =3D LOADBAL_HASH_ENTRIES_MAX * hashSizeMultiplie=
r,
                  .key_len =3D sizeof(flow_key_t),
                  .hash_func =3D app_hash_crc(internally it calls
rte_hash_crc_4byte for v4/v6)
                  .hash_func_init_val =3D 0,
              };

First, what is the return value, which error?
we captured only the return value, and will check what  error it is
returning.

IPv4 Load-Bal Flow hash table:
    numInsertions:          998214247
    numInsertionsFailures:  4252
    numRemovals:            997197485
    numRemovalFailures:     214902
    numObjects:             1016762
    NumBuckets:             75497472
    TableCapacity:          75497472
    LoadFactor:             1%
    NumLookupSuccess:       389165605
    NumLookupFails:         2704814006
    Failure Analysis:
      TableFull(>=3D95%):    0
      HighLoad(75-95%):    0
      MediumLoad(50-75%):  0
      LowLoad(<50%):       4252

We are try to analyze the code and find out the details,
Initially there will be no issues, insertion starts failing after 24 HRS or
so.

Thanks,
Venkatesh.


On Sun, Jun 8, 2025 at 9:17=E2=80=AFPM Stephen Hemminger <stephen@networkpl=
umber.org>
wrote:

> On Sun, 8 Jun 2025 00:36:02 +0530
> venkatesh bs <venki.bsv@gmail.com> wrote:
>
> > Hi @dpdk community,
> >
> > In my application, I am using the dpdk hash table as below.
> >
> > 1. calculate the hash value.
> > 2. using this signature add the key and data into  a table.
> > 3. lock is used in the 2nd call (add).
> >
> > Below is the code sniffer for the same.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >      hash_sig_t sig =3D rte_hash_hash(hash_tablele, (void *) &new_key);
> >
> >      pthread_mutex_lock(&lock);
> >       int32_t ret =3D rte_hash_add_key_with_hash_data(hash_table,
> >                           (void *)&new_key,
> >                            sig,
> >                            info);
> >
> > if (ret < 0)
> > {
> >          pthread_mutex_unlock(lock);
> >          return TOS_E_FAIL;
> > }
> > pthread_mutex_unlock(lock);
> >
> > return OK..
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > My application is having a lot of threads and when run with heavy load =
,
> I
> > am getting a lot of insertion failure, i felt the reason could be
> > calculating and adding the has value in 2 api's as opposed to
> > rte_hash_add() that is safe under a lock..
> >
> >
> > Please let me know your thoughts.
>
> Which architecture and DPDK version?
> What flags did you use during hash creation?
>
> As always with open source, the first thing to do is look at the source
> and see what is really happening, rather than just relying on the
> documentation.
>
> I assume you are using the default hash function which is CRC.
>
> First what is the return value, which error?
> It might just be key collisions. How big is the table and how many insert=
s?
>
> Also, the current DPDK hash flags with better locking and RCU.
> This would be faster than simple pthread mutex.
>
>

--0000000000007202ea0637321814
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0<a class=3D"gmail_plusreply" id=
=3D"gmail-plusReplyChip-0" href=3D"mailto:stephen@networkplumber.org" tabin=
dex=3D"-1">@Stephen Hemminger</a>=C2=A0,<div><br></div><div>Thanks for the =
reply , please find the details below.</div><div><br></div><div>DPDK versio=
n : 20.11.6</div><div><br>#define LOADBAL_HASH_ENTRIES_MAX (1024*1024*36)<b=
r>#define LOADBAL_HASH_TABLE_SIZE_MULTIPLIER 2<br><br>hashSizeMultiplier =
=3D LOADBAL_HASH_TABLE_SIZE_MULTIPLIER;<br><br>=C2=A0 struct rte_hash_param=
eters loadbal_hash_params =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D NULL,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .entries =3D LOADBAL_HASH_ENTRIES_MAX * has=
hSizeMultiplier,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .key_len =3D sizeof(flow_key_t),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .hash_func =3D app_hash_crc(internally it c=
alls rte_hash_crc_4byte for v4/v6)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .hash_func_init_val =3D 0,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br><br>First, what is the return value, =
which error?<br>	we captured only the return value, and will check what =C2=
=A0error it is returning.<br><br>IPv4 Load-Bal Flow hash table:<br>=C2=A0 =
=C2=A0 numInsertions: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0998214247<br>=C2=A0=
 =C2=A0 numInsertionsFailures: =C2=A04252<br>=C2=A0 =C2=A0 numRemovals: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0997197485<br>=C2=A0 =C2=A0 numRemoval=
Failures: =C2=A0 =C2=A0 214902<br>=C2=A0 =C2=A0 numObjects: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 1016762<br>=C2=A0 =C2=A0 NumBuckets: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 75497472<br>=C2=A0 =C2=A0 TableCapacity: =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A075497472<br>=C2=A0 =C2=A0 LoadFactor: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1%<br>=C2=A0 =C2=A0 NumLookupSuccess=
: =C2=A0 =C2=A0 =C2=A0 389165605<br>=C2=A0 =C2=A0 NumLookupFails: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 2704814006<br>=C2=A0 =C2=A0 Failure Analysis:<br>=C2=
=A0 =C2=A0 =C2=A0 TableFull(&gt;=3D95%): =C2=A0 =C2=A00<br>=C2=A0 =C2=A0 =
=C2=A0 HighLoad(75-95%): =C2=A0 =C2=A00<br>=C2=A0 =C2=A0 =C2=A0 MediumLoad(=
50-75%): =C2=A00<br>=C2=A0 =C2=A0 =C2=A0 LowLoad(&lt;50%): =C2=A0 =C2=A0 =
=C2=A0 4252<br>=C2=A0 =C2=A0</div></div>We are try to analyze the code and =
find out=C2=A0the details,<div>Initially there will be no issues, insertion=
 starts failing after 24 HRS or so.</div><div><br></div><div>Thanks,</div><=
div>Venkatesh.</div><div><br><div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jun 8, 2025 at 9:=
17=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumbe=
r.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Sun, 8 Jun 2025 00:36:02 +0530<br>
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

--0000000000007202ea0637321814--
