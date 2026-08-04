Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63105C55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 20:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D2DF4042C;
	Tue,  4 Aug 2026 22:42:56 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0579040285
 for <dev@dpdk.org>; Tue,  4 Aug 2026 22:42:54 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so112775a12.3
 for <dev@dpdk.org>; Tue, 04 Aug 2026 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785876174;
 x=1786480974; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mDBvr6EfkkuQ0MAaV0nGf35Ap7/zSQO6xL05o4ruYhg=;
 b=V451n+xDHOs6lu7grPsfW1bmfbxrKInE56VFFPo00giWYZcDCC0dfaxArHH81lQUVj
 ktHdSgY9OHggw1rgj2mCFpKuJU/TafaL8UGmlg4xtcIW3F5SQH9l1c5Jo53YNeALpOUP
 thTsnfVBlMyRMfTlToJf5ORwA+ITOp1L7hE6L/npRLbZAOxajTzGrfhJCBmf6JEE83Fk
 iD/24SeZigT/utc9vuYhzWlw/o8oyVXPUwIyqXyw9SuWKw5f/65VqkQ8MdDEOiVLF9pP
 qs2VFAWTadcN7rIhaG4GWU78x0S7HVVBBz90Lqi0lkj3C8H8xH9OQO92ES2+MWHerp8l
 ye9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785876174; x=1786480974;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mDBvr6EfkkuQ0MAaV0nGf35Ap7/zSQO6xL05o4ruYhg=;
 b=Uqz7M45NE3c/hJeCdClusxvNIXzRBx/+f9pmtysHyC8ZKZB+yXl4M/lqEIlHJL++td
 eULE7eAhYxjOX7wX+xbd/wJ/d60kEj0l/56L+EZA0sFaGMjxpRTySTYsJMsVo6M9Rk41
 IrgWfry/gkjo4mB4eLTsi/APIGEu1QKUNpSyJbnt6mqzhk+DN9NDhfLWBsroMVhd7cuD
 RqtIprKzbrgCNLH8uf5e+xEr68k3qE/qr4yUBIxx/rJ6FTbwwowZtcAzn/Aczw1VYq0e
 rmWmlQFMaCqIuxK1nVh0kr7ZAwKYpHcmUhKtnarUnf+xp7/X65CKvGUmeiILrnmfniwK
 SolQ==
X-Gm-Message-State: AOJu0YzNPyQJ9JCq2Ed5zKVsBi4gGPnSBU6MowMWIA/JTFio9FahG3j7
 huqQX3MSE55oHjDuHFwdA6bo+ljbus67+belHcCr8JP7DVDjkdhIonEGPT17LiUK8rA=
X-Gm-Gg: AR+sD10F3LtVjr8QI7o7QFJPRPuT+mCpjaQPe8fOHf1Cx1LQdCgzIxMQNtAcpiF6tWz
 oGtLLruU1kU59XLg0JVsZC5shqTLs/AyDn/e4cLuqS9ZeVlMbj3s3yCwYnf/rCnJQOktH39tcT2
 anbFSX04ifXfL8d+EzCNd6cFohLt3FhIZatfXspJGnOsi0z94UIUr3d5tqj5MBXUzBmr1YWwSmV
 tJHGCN/BpOWQ7XAp40De4Dfj1bnYGsVAIvRDoNVlqbHv6lC/R8gej9zoji/KUoaoHNwgj/UanX1
 FHVO9GRg2B4r419wuIpHOMYtmyC3aLd7FHGLd1Qn6TUoXpUeMGWAfBNQFEXQkobQO3w5Qbbq2OS
 PXdOdvaMEKg+I/Y3+TQOFz/1BYTfDAFBS7ZbfSsZUtVRo7r5pG44KJNC1/Xv3ksaGucYgfGfEpR
 /wZMCDkYYkv7KQ+kGQKwOpCvXXmfYhlynmQQwGl4gPWPD6+LDjB/X8GSm4OBdkdCn184AAt/oWk
 Sq4tV3zSR+r+/ODBh413uCr+pOORmV5yIM/ssTl
X-Received: by 2002:a05:6a21:114c:b0:3c4:3767:adb2 with SMTP id
 adf61e73a8af0-3cb85df2783mr1559033637.1.1785876173764; 
 Tue, 04 Aug 2026 13:42:53 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586162e80sm8553984eec.0.2026.08.04.13.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 13:42:53 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:42:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Bruce Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Message-ID: <20260804134249.04b718af@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659BB@smartserver.smartshare.dk>
References: <20260804143305.1344327-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659BB@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 4 Aug 2026 21:11:51 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> The AI in the CI is confused, so the AI Code Review warning in Patchwork =
can be ignored.

No problem, the lack of tooling and weak model is causing lots of rubbish
