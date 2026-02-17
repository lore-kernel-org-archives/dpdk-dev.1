Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D60FE68147
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:20:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5410E40653;
	Tue, 17 Feb 2026 18:20:30 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 753D940281
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:20:28 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8cb420fbb5dso266527385a.3
 for <dev@dpdk.org>; Tue, 17 Feb 2026 09:20:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771348828; cv=none;
 d=google.com; s=arc-20240605;
 b=kKqTRL++fMQnzLuhf87DWKMorU2B7ZFff1+x31aS3Jr5sUmOD2zh2NSCkIa/Locjlp
 WkR8T/kNBOJH8PfMQE21sAlkzZ93uHbBQZC7ycgZC5sQxVIC3pXVxI47n3gjjPV0K5cK
 ZB1WFyQjDVqwmDnHZ5RDjmiY/qU+KLG3AnyaRNfu4BwBJgBanUyjB/9UN+abceLWJoV8
 MWHCIPdV5Ew/DGp1aNaqTmIk9vUCheDI5yAWIpJLgzQn6pCJxfNEuxgcrQcu3OoqQdpo
 7beh8spqHGuhPf+IlU9wqxb4VdqAgIpHYAbUm5esSdjH1kgqKO8DBDqkjk4q9aGggXOC
 q0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4UCKkfn0rlQyHkuyqfThSawtjca43TqU45QryE/70PA=;
 fh=bIHfGx2ixiZ4Dm7PncgYjlJnwUi7fcdMy9cPZmaJtcs=;
 b=RdA3RFeXq4ykXKSC/mqRDXDDcOpXJMdmA4mOo5OokyVqu06MS3nP+5OWv3vhtyg95R
 Q6eoLhJ3S77p1cA9jWjhSB9em0NHDxTfIWs99BsJE56RzhOM3C407v/q1jtXl+aeLExV
 RDzVhmxCbWhoyMALOaeSgtdj2aJ0XC4NlPdboeK+02zKvSuR7907lMKl7gplTTRaUe8u
 wpTy9dEcDuna0x9zfVRMUHfZXWRVGIaLnsYUbqY2ifmWhT4RvGJFGY/KuiZ0zs9bmZbk
 9tVABAHgcCABv8Nx40z5VhVBCScMDkcykiCfvF6Tz/Ou7WIMupn7sbpr9+TNfMoeSCqj
 CyAA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771348828; x=1771953628; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UCKkfn0rlQyHkuyqfThSawtjca43TqU45QryE/70PA=;
 b=eLiXRFMk+nzMtoraSpaF1Die7fFMGV+C/7ziboh7MJS1zAbNMNWYE1jR3sXWvOU+wz
 ZoDtdjV/7a2HWAlNcmGAoy65WxSeLJEwR4+9aDBmk1vVT1kDbN3hwlMeyZ9lQ2X2z/+d
 5P8WCtMrDQWV5eOhRgcyODmF+gO9jhUvlNmZgNI/CNdHuF7aVXoy86QXC0B6zKFhUslS
 dUvJRUQEnQr3TKszfqIu+P/XZxYUV+InQPBtKIyDGRbSCG8Pirps1q7zCMKKvk82+AFr
 E4aXPtrEgPIHkj0s35IGvO6Hm5dDF9zR3wXNvlOJkB0gSzV1eobOsNTL7EZOSLCNo1C2
 DQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771348828; x=1771953628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4UCKkfn0rlQyHkuyqfThSawtjca43TqU45QryE/70PA=;
 b=difCtG9cQM5otUKj935OzaRKV6XxmByX/FV+2WrhhGbgQw4ZsD4Gz7+TdhRhXP8xlg
 n+t8SGSbIzUIwSXdbkvelH1oPFFytT733HAMvFvBmiRXh8lnFQlC/fpdKNf52PTuJlFy
 WVCXT35ehBWAp7oiZdcIwwaach0kvis7KG+qDZ4ZP4RgTA+KsmLbdEF34Cbtq57F59UZ
 xZ+E0ScfI7Xd3f1P5QAGOIKOoN9SqYzUt5iMx5vd9gMKkC0EbgWwmn8UldBhySoehp4H
 B3R6fLgDOc6/44kHp8DjIrGMUOOIRLvWDjk9F0bhZLaWQgxyYXDd0MmsDQ9Dz6AILK2k
 cbtw==
X-Gm-Message-State: AOJu0Ywigqdtex4Tk4GRpHED5LZfNm83jkxmS9rEUWt6m1bLKZgLZhX+
 IV4HAPGtJjiIgnUTzdZGgvOEIYb8EqQZN2jtBu02dB57Uy1ZvvsB9+dCKTNXifSJbLrn0Nvki5w
 YnRVwY7D8MM3+TYtEqn5W0GMh44b6z3g=
X-Gm-Gg: AZuq6aIyB6aflj90+kisrtH5SH5VcHBqGLriTPa8J8s1bWWOrzBWXgWyr1El4UCiggX
 5iXH2R9ZOSP4H6jgpT203uaw+XA24FdfgCevB8+NgazSOcQGzmulxBwYORsRp0aBUvY51+4VP+/
 jE8CsJFgjPV4kXixbeeG61YYZu16OhsebBmr11A6rLvaaFpPFjc16IF64Fjcp5T8Zmk473lzMI/
 yqOXxCdA7cWjLtHOzI2+hIvSt67uwptFtg7OkjAvZknxzbxYC6DWIUTJrIFRFQsyDeO8MHTmiyb
 N8LvxOFog+VMJw==
X-Received: by 2002:a05:622a:1103:b0:501:3c86:80b9 with SMTP id
 d75a77b69052e-506a8313531mr185822441cf.40.1771348827676; Tue, 17 Feb 2026
 09:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
 <20260217054345.2759687-18-rbhansali@marvell.com>
In-Reply-To: <20260217054345.2759687-18-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 17 Feb 2026 22:50:16 +0530
X-Gm-Features: AaiRm52SVbozCM2B5qXW8aoMNaHWIPkXfaPeKwDWqQw1SLZtn1jcayICYZH8Nhc
Message-ID: <CALBAE1MN-ubyVH=rG0LPos0C_faJbJYkZ5ZEKP=diua94ubiww@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] common/cnxk: fix duplicate branch compiler
 warning
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>, Archana Muniganti <marchana@marvell.com>,
 jerinj@marvell.com, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 17, 2026 at 11:16=E2=80=AFAM Rahul Bhansali <rbhansali@marvell.=
com> wrote:
>
> With compiler option '-Wduplicated-branches', getting few
> warnings such as "this condition has identical branches".
>
> Macros are updated to address these warnings.
>
> Bugzilla ID: 1811
> Fixes: 0d9e323bacf0 ("common/cnxk: support for CN20K inline IPsec")
> Fixes: c045d2e5cbbc ("common/cnxk: add CPT configuration")
> Cc: stable@dpdk.org
>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks
