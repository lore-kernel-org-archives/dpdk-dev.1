Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A85CC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 02:54:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F17E4026A;
	Fri, 10 Jul 2026 04:54:35 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id EE9FB40268
 for <dev@dpdk.org>; Fri, 10 Jul 2026 04:54:33 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so255215f8f.3
 for <dev@dpdk.org>; Thu, 09 Jul 2026 19:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783652073; cv=none;
 d=google.com; s=arc-20260327;
 b=KCnVaH/uuq5ACt9MZCtQeOb+jpIfyOuaSs4MkTo4rTu3NiQ5HNFGtrAPTD4hqnU4wi
 mMYDDhMWixKPnqR6TXjkQnwuPHLcCtAElCpkfVpLWyaiqadj35tJtxubJoTy6YJ+Q5zG
 W3zcEAdQTlqfuExC/xLn5i8bmxhASgXrGh93vL/4O3MNw1zCLA/ShtjsTvQpHvhG0MHc
 E3LW192x0wDd0xfsaCs59Jcg2l68R7gy3Tm19EFkbwG3eLLgArWf/WJnzuXBzXPwgsZ8
 PUglN4zarQpAzw9CnF7pyndH4GtPPYiZQrQP/kLfHn5+HyiyBR2Mw495BuCqLwk2FC3C
 XtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QSHaf3MxUBWPVqs2Kli1i2u1W0PLRISbAORSmrJsMYc=;
 fh=1U4gzvhWJZ0z+Y8NBoBNchQJX/4Nu7wLGrXlMBgJ2lQ=;
 b=bgGLqjZr02o8BKEwV0DM5lj+xXKn03lPaNQUWtbPDpLykTVqBri2KR+XRkLjjr5CLs
 +bQ6DxjN83t1WfuBQPLTSoIBp8XP8i/ibEhOZcb/ZIxAYQHPHSMhKqfmHsJvM+YxXCfW
 5xvdvjJblNa1XTcTIQBrBP/eXQZJHk8zcL5p9wAL0jYalZSuhhfOrHUh7Ocfao/fPrzh
 dXXqr4wMtRXst6hl1AQH/bK5xMo6yx1ERYFtBFYmVmKpCIdmVbo7cLjuZPlAzP2Mi3Iv
 d5EidFbSZKCfFSzs/p5w9k6ytsYR8f5taRXPqB4tb+UtONgV82UqLO6twgKRtJxYldC7
 QP4Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652073; x=1784256873; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QSHaf3MxUBWPVqs2Kli1i2u1W0PLRISbAORSmrJsMYc=;
 b=mJEH07JWtK0FldpIJQf8tHUjmWG2+PQDbipvviO0etKLKrttfAJtdMtkI6Q06B4I6m
 mqqP8gzrBUITeRs1m7uD8oCvetKbqEGkycZx3pHAmmWYQQGOfgTszVdtrCZN1QCHuMGj
 TLD7zWCikFTPLZgql77b//P45E6u4K1f/qRcXbYqRo25IRMRSgWTGnq7M0AM90DfXznM
 BZZqwgpYyLj1uB77VxJLREusJGbMg0pGIehBM4vWT3fENhORfqEwmeaMqnVAH4A13KmV
 44MwjPqMyT12ZtDCH5kHbzLaalKvIsStJChVqRmS7BmK3fFCPE3vYDYSNWpf9isYZFFC
 9XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652073; x=1784256873;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QSHaf3MxUBWPVqs2Kli1i2u1W0PLRISbAORSmrJsMYc=;
 b=dNYvAhirPAxW4PT3HM19fiVSlC2MRTegGW2s/NNESQi/4pNGCvvsh4qz6bLS5PxK8f
 DHQ/OosW9h43VIMV3afR+SPbAyVCIC2zgzJkDbdC1p6zL7PRHIXRgEJpal3oZVQsbgAm
 Bm0xrpAquKQCfDh1qFA/yo3EPCVdzXl3qGGE4V1FtYQJ4KEwW8TlVz9bBTsUpTeyVd37
 VZtpy9qkobAq/RnsrX3zpYFBmkNtuByAr0gS4M8oCh2XZLk+ZmcAVWr3hUrUSSN7Hbee
 gzczr4ERG54GMxw0FvMPmgW+U2xYlyzUQI/oqzzOysfOPx3DAhiKB3R8Jqb8dgzvpgq1
 iVCQ==
X-Gm-Message-State: AOJu0YwbggvgoHyPbA7sL4H0PRwlmVwt1OJXm2nPQbWfmeWpzna1phaU
 lEj68p5Y/NW0/WrSfgGBLVjZRuBcLgDjWABxvVq6jZ/5OwM8re4z4LsXEuecHSs1RghpF+7lYdB
 u6Lc+ZA/L+i5GhMOFrGPImmSVjeCHoDw=
X-Gm-Gg: AfdE7cnFGU8GrmF+wP3mBJ41EDV7K6YJs3FOpRTJ3X2flJvt4ginNwho0yMedPSK0QJ
 5sfEvtUlDnqBILSgvefD/mhlD038iEy35eqySruguK0VoQwyWhxF7hxS3pG8n5QsS5NMS/IXLzc
 4fPtN9p0xzpCPCP38D0dZiLp06Pj3DmThz6QYRI+tKvKf71Y/rZgX1nKaNg1HHxx8JANB030F9J
 C9f7LFipo5ggtBQVh0TyN+I+60OMrj5lUlQPdNLvVglMbspFZoiBRNfKqD7c89+wL1jE4MN3x/P
 k5vICTLUSsgrdCHFKjJMHTl+0PuJ1yxhe4J2YngaVGxxK/FS6SwLW5/grsG3pqnUl6c=
X-Received: by 2002:a05:6000:24c2:b0:47d:dfea:f733 with SMTP id
 ffacd0b85a97d-47df07a1f1cmr10379646f8f.3.1783652073459; Thu, 09 Jul 2026
 19:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260220192510.37163-1-abailey@iol.unh.edu>
 <20260709175312.1018085-1-abailey@iol.unh.edu>
In-Reply-To: <20260709175312.1018085-1-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Thu, 9 Jul 2026 22:54:21 -0400
X-Gm-Features: AUfX_mzQ0-uAEjElVgaYewWsz4P5sAOwIuJBwLCoa78FSHaA_kI-sHv5HHEnrGQ
Message-ID: <CAK6DuxtjLjygPN4SQ3EXJ+m-dpvjAspoapxNFi_0d0S4rXgygQ@mail.gmail.com>
Subject: Re: [PATCH v6] dts: add support for no link topology
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, knimoji@iol.unh.edu, 
 lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000003dd4da065638dcfc"
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

--0000000000003dd4da065638dcfc
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts. Thank you Andrew.

--0000000000003dd4da065638dcfc
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts. Thank you Andrew.</div>

--0000000000003dd4da065638dcfc--
