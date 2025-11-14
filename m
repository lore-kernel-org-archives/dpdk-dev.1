Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D2CCE8D4F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:18:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89F8640A81;
	Fri, 14 Nov 2025 17:18:24 +0100 (CET)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 67ED740151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:18:22 +0100 (CET)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b556284db11so1449932a12.0
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763137101; x=1763741901; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dRlY7kCZHRLSfyxt2CFBcBcTPVmLg98l2Y1ilagqMVw=;
 b=Mldc+cyhkCzzTSC9abMh0GaE2ER1qpy0R8dXTAIi07GteanjHWEhF+BOztMXsINjAK
 O9jAIAOhCUMLu/mQQE+lcBr+cDZ0AJC5ZCO2Zg99k74Yu2t5lRM2yeLrsyZh9rUpfPgQ
 BPiaoqvCQdTlCNQt74Ps4pu+Rb1gvujKE/21U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763137101; x=1763741901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRlY7kCZHRLSfyxt2CFBcBcTPVmLg98l2Y1ilagqMVw=;
 b=llawo+nKwiZ2Ed61gjUuk99fg0MBq2bqyfVkQzqfMcGUJENO2jBViQJ2VSX8H+1W8W
 nFsAz8k1Dlw7EBeLmUtOJaAB4XhyXI53goow5m4sbLv2b0Zg6KmeAKUZt/YrUbhlyjLN
 Ety6rgjtQ9MiAWcPzwcVZnsJu15QQmvE4oar67HPPUiCE7P3Mws6R/UzcsXAiDi9Pe2L
 Xuz83muDVuxe7zpcO14IDmpg/wg2JSW5eBnwgLQr9XAwzbkcXf7SZhA8D3VvN3rpvuZC
 xr83mn2xKeODG0palsm6Qn17viYZXe1GZqG8rwuToz1PeQCtLaFUTFuEC3Ds1/5/UCFo
 HvYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgMVwnrY/MiecLS+lOFP89LmKgv8egAKtbDIquGXkww5jEXpuoIf02W56pGo80nfJ/fBo=@dpdk.org
X-Gm-Message-State: AOJu0YyNBYlv6EWRMlLEVk6dnvYY+Q/Jx45gzDCXWSPTRcMYUMJ5Xdzr
 5tO1OYScTkCTeqDpuWrd2o9KxYQMyigtXQr2E0GriP+iPYwQxwHKMmNdNhy6PWnfauwR+6LVUb9
 1/zsHplo6Q6SOxd2F5lfvRwLyCJ1uBb0vdHuuMt8qfA==
X-Gm-Gg: ASbGnctVHtyVn91F6M8rFwhZDsJo9vVTrc2G3KB2gAt1xOPa2BnBVY1X+OvsRVEsCo/
 F/g+Pn0XjgBM4rFSn7peOlxMSXi13T5D4XtSs1fY4gh6mqP/26VotZGzlCDl1BVfVPNaqumCgQo
 rsjACnwTaMpcr2NjP03ga9N20wHA/M45uNkugdznM4e5k9VcwkyWtfURer3G8SaEedhRZLMFw2S
 3wGsZagFAMZefquMu9NDAOsoQfH6qReyXnlfQFOduBNOwjoht4F07KTQhA+SEKeO8z/76nyWJzn
 j3RVmrb/vbc=
X-Google-Smtp-Source: AGHT+IHGzP95PUHSS65YRFIwXC+Ha8OU4jG0ahFkOGSzhFPdufU+7QcoxEld8vNXmrPDlQKZcV4N6FpJgEPLqq7P+JI=
X-Received: by 2002:a05:7022:b902:b0:119:e569:f61e with SMTP id
 a92af1059eb24-11b4140731fmr766871c88.23.1763137101383; Fri, 14 Nov 2025
 08:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20251024181606.604135-2-dmarx@iol.unh.edu>
 <20251113190309.310821-1-dmarx@iol.unh.edu>
 <20251113190309.310821-2-dmarx@iol.unh.edu>
In-Reply-To: <20251113190309.310821-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 14 Nov 2025 11:17:05 -0500
X-Gm-Features: AWmQ_blRCdZyJfyj5ooHTa6E-K34UAHfvsvf8so-5-YBUPBWlvZAznuJf5H5qgk
Message-ID: <CAJvnSUB+21qM1c5pHOnNSaUhiXdQtREv4rzbFu5exe8ZMnU8dw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dts: add QinQ test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000009e5e0506439058e3"
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

--0000000000009e5e0506439058e3
Content-Type: text/plain; charset="UTF-8"

Hi Dean. The testsuite looks good and I would like to merge it for RC3, but
in my final testing I see there is a doc build issue.

To resolve, can you please change both instances of "Packet | None" to
Optional[Packet] and resubmit to the CI? Then we should be all set.

--0000000000009e5e0506439058e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Dean. The testsuite looks good and I would like to merg=
e it for RC3, but in my final testing I see there is a doc build issue.<div=
><br></div><div>To resolve, can you please change both instances of &quot;P=
acket | None&quot; to Optional[Packet] and resubmit to the CI? Then we shou=
ld be all set.<br></div></div>

--0000000000009e5e0506439058e3--
