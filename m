Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C324AC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:38:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0552542EBD;
	Tue, 15 Sep 2026 15:37:33 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 87B3B42E74
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:26 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4b29fa803so2311861a12.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789479445;
 x=1790084245; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UW5DN/CtCOnGikDYF3MuKtTk4CqhsB3E/h4UAmW+KIY=;
 b=sTFHJzjMxX2yCiSNYFII+buFTBTUflzTay6ND6jUAaZCZfm/ceYKP9Os3VYhjOA3BV
 5Au/AoTkjDRFjoJg9Tljd/r1k+lZvBRjq2k0ydXkF/cUeHAsqp5aJoRBQwe3PMTY/8u+
 tMcsQVBCFJZ7Z74RJpMlAmmwzg64Os+OVPU5f1Gz5B1kCnfsgFJ3oSlT+68XZqHO/biO
 +A1ENqJPHi6PH7FCJdNED1GCCikVRZIs6RthDPZFeLPy/JfzOyu2oc5tpd9mZTusmZBF
 WLlkU+Lqtnjx/2/wAaKnrizL6JqgtPM6k8O5L1QdijonkGX7ECLCli6iUOm/wq37BIQE
 t3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789479445; x=1790084245;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UW5DN/CtCOnGikDYF3MuKtTk4CqhsB3E/h4UAmW+KIY=;
 b=HYWCP5YgOC6Mjl68BdArG/VW41qPOPK/CDpagdaBhO+yKIn8Ea5LLSGAeP7qHjUid0
 JIgFhjZMdd0J/1109/TDS9IvwGdtWsmrJzebxzknNEh7PWCqon2k+ZFa5/5Ct5eVyMOU
 4Z/n4D+udnmHCtkf1OilUoMquKDHUdYcKSs3ErjbSrpgkKCrL4M8h/jVBEG6L8RsZmGf
 Ac9xUQGRh0inAASAEECvayuryaXHJ66IUf/iL8LaHsWnEQBPX6ckzFGABvXXT/dQxAdI
 wFmXTSTiseAozVX1yJdO/sTKprJFYsqi79jLo4fHWLHR+9Vb7f+6JkpmBy+haZokLENb
 FSoA==
X-Forwarded-Encrypted: i=1;
 AKwUvByXh0IisLia0/Dp+51uOjCw31fKeByVCkcNYCV3q9XfCOyrdGa3JweIpJPHFgfrmGgpaTs=@dpdk.org
X-Gm-Message-State: AFuF++mX3tKfquDey4nFmv7I9lBXotWRUB4PbFqoulDuT7VwpXXR4NZI
 8/2lJdo7nVj9kg6MrzA9El58eRNxzczU4PB79DD9WnNhd5GMshWao9yvHZy/AY053Ss=
X-Gm-Gg: AYBFou0m4zhMMTkJ2Yd/DvuqkZj9BjuKVtUCJZVt9yRB/zrdm9BprWkS5d6H06djfUR
 cXm3T4tZTX91etbkxXuNq68rnn4yduRYmJZ+8sAejWZPmThYv0CiVCl+ASwtLadS1Iw8efomTEj
 gvgvY7ooKh5uCozGVkKu6CI5Q3xCTNwvdWnEbyohXNyXwTCWUXSeB5ZU9KC1b1VVhEYB5mxxLh+
 mjEnoQYX8hn8meVE7uctOng8d07xEwZ3HjKakAFBZvEZb/UjA5ghmZobvy9M8BjupKN+V1bH7tH
 jeeZKv2JZtvFeVPSjSzy6DdL2/2irmmNek4iOoKhlsrLEf2n1pVBS4s31qemNtXb55YJnXBkt5h
 hX1czl8MrbCfjwBe5xBkk6DbLWO/urZgHb1dddXSukTuaLDnJR3MKcKsObjHiAAma6FEeg2lXCY
 mRyItMlNrdHPQMnHl7CEwnGwjurf4IVABok5zSmPuPxyC2+U01/fgGLpDz67s/j51cZPYqzu+xd
 zN8u6FKQWj6LKUPWt23z+biMJX0F8BXn+zELi/U
X-Received: by 2002:a17:90b:4a88:b0:398:bacb:1137 with SMTP id
 98e67ed59e1d1-39dec0b7e19mr14737267a91.19.1789479445518; 
 Tue, 15 Sep 2026 06:37:25 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfd9c2f98sm5327484a91.1.2026.09.15.06.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 06:37:25 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:37:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] Adding the return values checking
Message-ID: <20260915063718.415f649f@phoenix.local>
In-Reply-To: <20260915104005.467027-1-Evgeny.Sokolov@infotecs.ru>
References: <20260915104005.467027-1-Evgeny.Sokolov@infotecs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 15 Sep 2026 10:40:05 +0000
Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru> wrote:

> ---
>  drivers/net/bnxt/bnxt_ethdev.c          | 29 +++++++++++++++++--------
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c  |  2 ++
>  drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c |  2 +-
>  3 files changed, 23 insertions(+), 10 deletions(-)


This is covered in the kvargs helper patch series.

Also please provide more in commit message and should these get backported to stable.
Should also have a Fixes: tag.
