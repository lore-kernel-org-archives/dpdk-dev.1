Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD7DC61CE8
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 09:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD380402D8;
	Sun,  8 Jun 2025 11:21:56 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 7DAE84014F
 for <dev@dpdk.org>; Sat,  7 Jun 2025 21:06:15 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b1fd59851baso1705776a12.0
 for <dev@dpdk.org>; Sat, 07 Jun 2025 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749323174; x=1749927974; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TDEaR7u52cNkXk/gO4bgGy8Ak5B58WYMWK8f47u85jQ=;
 b=ZM4gXfHbuAowxFGomxC12K2m5oVok0iGAro1C4kVZOT3WGOihjiew/zx/39mwMO+O/
 BpcSeGxo7kJ4MrNpOu3A3iApfypAYRtoklV3LHk9qYeotlFO+xaNApR8iCCi4cUF1osi
 AksEcJonDTIjJPywfBmRNuehloqNszyVHLwyB6xwQnarihXRFGXeTfBhnz22auisDrUf
 pukdG76BAe8X2pvONblPLW27OOVLMTrsmPVxa6GmNeTlbqdtvRUjjH6FYiQPnGmsc48Y
 SUuPFiyjMABgu50YZLH07jndBLx5489SZFXHaXWU08sYNVMFxUClZflnAwnSmRayxcw8
 nTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749323174; x=1749927974;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TDEaR7u52cNkXk/gO4bgGy8Ak5B58WYMWK8f47u85jQ=;
 b=KZBBDzhP1Tp+yC9Gb34Ofw5R/tGEjTn+xvcxB5ZVSl32A+dAhFNUkIVQcXFgq07yve
 HzqlJpZIESlKfZj2FeLS173+Wz9e2ci8FG3FzH7HPTsbxnrgat9vNwoDCEF78TFFi+8g
 v+PEd8eKxbi8rvGWhGsvAuIRxFHOZ0nelqu9pDQwZCynh1Hnj803WWhrRz+dblPsSePL
 0QG7xbolJfb/os0frD9BS2sCZeyY+RqgJ2vVfyNQy5p41AZom+T5A1AmkZ9H7m3GMkD9
 e2ILJ/qSdBf4gzbjuhRofQ73+lwkIWsPeihoJnMIESQrEST+U5vitrjbLtSZNd8Hv1ma
 s1NQ==
X-Gm-Message-State: AOJu0YwkV+TbIrQlJaZvdyW1mPgOben2WXtyckNw/TOxzQudnHcRaWVH
 x7dXQbXO4X2rEJEFa+Q3hd/mZM8QKD2L3SGGHoCjDSJBhjEwBiwO2v+12mCAO4uRAaHMsqH9m7G
 sEy3R/tbszRJ38t+x97MbAUtXpjoE2VBTR3U0
X-Gm-Gg: ASbGncsXeLqLxUMN/sIyT5DQ+2Md46oL2Hvg4lrlULIdeXG9zXS5D3uiHG2dXov/0SB
 ux6+PpQrcN1+lxgIdbZekRZFVNkmBU8860UOnA8Z0VO8du2YEB7rNviPwQyrVV21TZbCsGdBOtD
 eEm059HrzuSF3yi5naly7NRfdG+yF5kXWz35r01mzzAT3xkckYuQHG4RBCKSO1B6bIgJ5ujzxUB
 HJo
X-Google-Smtp-Source: AGHT+IEtDnByGsjMnVLtkfPMGctKLhxkuYHlMxu6+iY0TbuPqhlXAwWA65mga+vMn0dI3ln52ZzDtY2j2Sz9QWuHv68=
X-Received: by 2002:a17:90a:e7d1:b0:312:1ae9:1525 with SMTP id
 98e67ed59e1d1-31346b206aemr11890828a91.8.1749323174097; Sat, 07 Jun 2025
 12:06:14 -0700 (PDT)
MIME-Version: 1.0
From: venkatesh bs <venki.bsv@gmail.com>
Date: Sun, 8 Jun 2025 00:36:02 +0530
X-Gm-Features: AX0GCFsOYpBqSzLrMboKO8KpidP-dKwiMjt15Ai1fOhNYpIHLJw7JwELX8Z49zc
Message-ID: <CAM3UhOgt2UmtWhvobLyVzX=gmj46+RrSNGbfKH3fSQ-yhxTw3g@mail.gmail.com>
Subject: Question regarding rte_hash_hash and rte_hash_add_key_with_hash_data
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000063b6550637000a4c"
X-Mailman-Approved-At: Sun, 08 Jun 2025 11:21:49 +0200
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

--00000000000063b6550637000a4c
Content-Type: text/plain; charset="UTF-8"

Hi @dpdk community,

In my application, I am using the dpdk hash table as below.

1. calculate the hash value.
2. using this signature add the key and data into  a table.
3. lock is used in the 2nd call (add).

Below is the code sniffer for the same.
==================================================================
     hash_sig_t sig = rte_hash_hash(hash_tablele, (void *) &new_key);

     pthread_mutex_lock(&lock);
      int32_t ret = rte_hash_add_key_with_hash_data(hash_table,
                          (void *)&new_key,
                           sig,
                           info);

if (ret < 0)
{
         pthread_mutex_unlock(lock);
         return TOS_E_FAIL;
}
pthread_mutex_unlock(lock);

return OK..
==================================================================

My application is having a lot of threads and when run with heavy load , I
am getting a lot of insertion failure, i felt the reason could be
calculating and adding the has value in 2 api's as opposed to
rte_hash_add() that is safe under a lock..


Please let me know your thoughts.


Thank you,
Venkatesh.

--00000000000063b6550637000a4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0<a class=3D"gmail_plusreply" id=3D"m_2928094038661=
859863plusReplyChip-1">@dpdk community,</a><div><br></div><div>In my applic=
ation, I am using the dpdk hash table as below.</div><div><br></div><div>1.=
 calculate=C2=A0the hash value.</div><div>2. using this signature add the k=
ey and data into=C2=A0 a table.</div><div>3. lock is used in the 2nd call (=
add).</div><div><br></div><div>Below is the code sniffer=C2=A0for the same.=
</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=C2=A0 =C2=
=A0 =C2=A0hash_sig_t sig =3D rte_hash_hash(hash_tablele, (void *) &amp;new_=
key);<br><br>=C2=A0 =C2=A0 =C2=A0pthread_mutex_lock(&amp;lock);<br>=C2=A0 =
=C2=A0 =C2=A0 int32_t ret =3D rte_hash_add_key_with_hash_data(hash_table,<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (void *)&amp;new_key,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sig,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0info);<br>=C2=A0<div>if (ret &lt; 0)<br>{<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_unlock(lock);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return TOS_E_FAIL;<br>}<br>pthread_mutex_unlock(lock);<=
br><div><br></div></div><div>return OK..</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D</div></div><div><br></div><div>My application is h=
aving a lot of threads and when run with heavy load , I am getting a lot of=
 insertion failure, i felt the reason could be calculating=C2=A0and adding =
the has value in 2 api&#39;s as opposed=C2=A0to rte_hash_add() that is safe=
 under a lock..</div><div><br></div><div><br></div><div>Please let me know =
your thoughts.</div><div><br></div><div><br></div><div>Thank you,</div><div=
>Venkatesh.</div></div>

--00000000000063b6550637000a4c--
