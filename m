Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C5CCD6E79
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 22:12:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75929402B8;
	Tue,  9 Jun 2026 00:12:16 +0200 (CEST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by mails.dpdk.org (Postfix) with ESMTP id 67DFB402AD
 for <dev@dpdk.org>; Tue,  9 Jun 2026 00:12:15 +0200 (CEST)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3966c0d5ac9so47073281fa.2
 for <dev@dpdk.org>; Mon, 08 Jun 2026 15:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780956735; cv=none;
 d=google.com; s=arc-20240605;
 b=MFcceS0WT322LoUulP5FrKT/2Vob2AV3pkCOqAkBsJN8Bl+KObgRMndoqECQktlQ8l
 wpd48ZVl3qjU/VZhqNdO9npahHAXtcs3Pdqlzy3LFeAhEaZptERX24dlAyEibdrWLVg3
 tHzNVvFSfyZ3b5VzV4N/Xi6pc0P1YWh8hekY9s0h4SukUiWX7mnvPy/93DFm9Po/eI/5
 +NzCJ5xHLWlCRlICoD1E+JlkAzx3qGrBqRVp2FSpZ4C6/iYiNTZdn8gMjPy/PHPmRVo2
 Oh1jhGJmdpXOQj1F0Gw9LY/lBal9Huuo6/NdShNR+LkRQb8kLisou6qb1UPNQerXJzBl
 h5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3w10uZlaqPItD2+mRG06qX+R4j6gdWtwWo6xevdwQQ4=;
 fh=K2Czu0Fju3HSoAeqvapC3G5KVDYaPNySHHEuPIBE79k=;
 b=HVFMM6LuDbbpYSan/svc3Oqsdo50dtHOwlYynlqO3/C21u81I061ty7ZJXBDUp2+wG
 tzCOdDyFWcThIExJV2V2rWV5xH0Pnm9/stFAtkUgxOXzBSDhMGi77PYJk3hXT00FCtUH
 TmansWGXQWF0Jei2Y3MyH3ME86+3edaumhmXxvyWJd98fmxCSQusMe9tIbWk8cpG9v5C
 o/J5guB2IrsbXgNIlOzqOBxbzUMDg2SEHD6AUdmEZF/aSQ7OuJskVUkxa6ILDydqz4hT
 1a0OQa6MlWN0Jv4/xu9gjfNOOcOA+WC6lX/xndOiO3bovRX44VmEfSLkKW+HzGhwFbKf
 JztA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780956735; x=1781561535; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3w10uZlaqPItD2+mRG06qX+R4j6gdWtwWo6xevdwQQ4=;
 b=IQj9nEO3OMCt5OspNpXa0i4z4BiJlb7hQb5y2Lcj8H/VFl9uKYiOqgwiJ5S2g3r1x0
 DBUpxp9uywrCXiS0CKc58Wvfhbb0wf3bFGgsF/fkZCZOmkgOKADsQrsK178i1QYwsV/V
 Ro5dn21dWLwgn1NxmRrPaiiiiOmMnf0olLd3K/bAzUgesq+yAuUt+T0Vbuex9i1OUB0Z
 ZlrxtW7YCgNWCT9KHkxOwDoBOR3FppzR1gbq6TOf945o0l2PIsCR0ZdFqnu1nt+2EVQD
 byTX+oVurHyshZ3NoghXkZJhMrhMxck0YM5eyMRWjrsCNoH6HQJVs4DPtW0bgHmiFdhG
 TMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780956735; x=1781561535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3w10uZlaqPItD2+mRG06qX+R4j6gdWtwWo6xevdwQQ4=;
 b=bi7MLyXoR5B3vTXsilHxs7JMoe6+6mTrG12TyN67LKwz9bT8ygV5mtcM0m65q+7xau
 jFjn5m511kKd8p8Gk7+B/QxDt84m9F/ry9AL6VPFhHd1pzLBhVfSCjaJraNbgVFrgPSM
 DonEB0SsDUfix7eVUOP1gyfuyGaNrTl6BWMK8vLzbNIU+8FgsUDqK42j6mHHNBhrsp5A
 +LHEXJlRQMFLVVKpR4/NI6V7hEPdfRZf1GRIKfUzndnZg29h3AKBrjrmtCCJ9A2Ts9uf
 thK5PUwCn7gaa9eZhIQfdaBCQ6hySrb5YtSqteV3mgug3YYdH6l4vNfRXPZDTt9cINhG
 hmFQ==
X-Gm-Message-State: AOJu0YwDlLDYkj3afZAwvQlcbo26XqkHafCeZ5ZtB6LnI3ybiVSZKHBL
 pW/szdEJqHv8kmKLILltHnn1OaxVWAS77NQpYKQ/a9lbuUOyMRjcIc8bw9lwvgGiabDqas7wXto
 w7gHmTLdiLrXY2R2t7ToApgRdLtSmX28=
X-Gm-Gg: Acq92OF6A1UOeI1U3+tkeUSk+GFyAJWQ31Rufgfrgpi8BIEXu/Z+y1tUpH8LqmCgojo
 ISh8jVIs0cSBtaEwDcn8DHVupKmb+U/RnN6SocfmOhYQBpqo+vrkuQ2oQJhauWcrAJCx49cRRbP
 mVhORbZ4ujs0WIGziP+6RwGc2eI3gcROwuZvWge65fVKjbNaQLj+fitXqbnU79wGTd+Bx8x3kwQ
 93gsekMaAX3grHLA4Ii2eXbbuLChoA281TbxPmUXb05gDJFUauk5TUItXssjCaxz6vSMR/OjQ+V
 7PykHKW/QjG3wlL+xb23Pey0MnTpCNqpNlsNBWcIMaZhGAQlViY=
X-Received: by 2002:a05:651c:12c9:b0:396:7a05:6ed7 with SMTP id
 38308e7fff4ca-396d074cb2fmr47068291fa.2.1780956734195; Mon, 08 Jun 2026
 15:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260224163200.39360-1-abailey@iol.unh.edu>
 <20260530203757.22139-1-patrickrobb1997@gmail.com>
 <CABJ3N2UVNvqK2y6776bVE0zufpcSERjiroNxpXkf26q_pgajzg@mail.gmail.com>
In-Reply-To: <CABJ3N2UVNvqK2y6776bVE0zufpcSERjiroNxpXkf26q_pgajzg@mail.gmail.com>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Mon, 8 Jun 2026 18:12:03 -0400
X-Gm-Features: AVVi8Cc-frGGreuPpYSHZAaLrfu2wOqxJg_vKbGTz6cVWWw0JTaiV--u9p-R60Q
Message-ID: <CAK6DuxteciZR3SMzjGLDbg=H6aDttynPMnCg1_HfUu14RhK_qw@mail.gmail.com>
Subject: Re: [v2] dts: add support for no link topology
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com, probb@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000808e070653c54da6"
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

--000000000000808e070653c54da6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 1:16=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu> =
wrote:

>
> Also, does the topology type affect whether we want to use these custom
>> args, if the SUT driver is ice? I guess in a weird case we could have an
>> ethdev test using an ice DUT which does not need a TG?
>>
>> My understanding is that if the link topology is no link, there will be
> no ingress and the ports on the NIC would not be used for traffic. I do n=
ot
> believe this argument will still be required if no traffic is being
> handled. Please let me know if you disagree with this approach or if I am
> missing something.
>

So, yes it probably does not matter which way we decide on this given that
no traffic is going to be transmitted. But, I suppose we might as well
maintain the same logic (compile this way with this DPDK PMD) as with
single link and dual link topologies, unless we have any reason to do
otherwise? But again, if we did compile without the argument in a no_link
topology, I don't think it would matter. So, in this case, whatever your
preference is between these two (as long as you provide a reason), I will
approve it.

--000000000000808e070653c54da6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 1, =
2026 at 1:16=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh=
.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Also, does the topology type affect whether we want to use these custom arg=
s, if the SUT driver is ice? I guess in a weird case we could have an ethde=
v test using an ice DUT which does not need a TG?<br>
<br></blockquote><div>My understanding is that if the link topology is no l=
ink, there will be no ingress and the ports on the NIC would not be used fo=
r traffic. I do not believe this argument will still be required if no traf=
fic is being handled. Please let me know if you disagree with this approach=
 or if I am missing something.=C2=A0 =C2=A0=C2=A0</div></div></div></blockq=
uote><div><br></div><div>So, yes it probably does not matter which way we d=
ecide on this given that no traffic is going to be transmitted. But, I supp=
ose we might as well maintain the same logic (compile this way with this DP=
DK PMD) as with single link and dual link topologies, unless we have any re=
ason to do otherwise? But again, if we did compile without the argument in =
a no_link topology, I don&#39;t think it would matter. So, in this case, wh=
atever your preference is between these two (as long as you provide a reaso=
n), I will approve it.=C2=A0</div></div></div>

--000000000000808e070653c54da6--
