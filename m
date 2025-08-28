Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7257C8303F
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 14:51:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B7E54025A;
	Thu, 28 Aug 2025 16:51:42 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 7CDA1400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 16:51:40 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45b7d87b90fso2508385e9.0
 for <dev@dpdk.org>; Thu, 28 Aug 2025 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756392700;
 x=1756997500; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcIPhoqtnTZR7Fe6b72YdWFD7zAQ6IdKYvZyeUL1tcg=;
 b=ZrGAKxUDjuUg0lf49B6aIlBOa7aOQDHbyrz/fcVmulcktBLtQEXzz4BVFftGMWFXQg
 zF0Kv+11jf0DVeTq1/BO6xC7fpN6iRilzMPa4sLiz1I3tBee9JaxdnBgEj7nK9bMvq29
 AD5HcmkNGRvDfZJXYlhB8VNeLSgTs9XxOM18xKjobDd7TciWVTg1Pkj5rw/uSf9Xk8H5
 2XGcP56zadIR7gUk6WBEyZP2o+sh0XYGXLzmWjJQszpy7vUmeejCteLpNr6LjdHTXwTw
 iR5I4FQ5kDmvxyR1pX2E2ei/lZkgVe8rdK5D4047pIx8FsgBbxoavLpjudGdUgSps81u
 rz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392700; x=1756997500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcIPhoqtnTZR7Fe6b72YdWFD7zAQ6IdKYvZyeUL1tcg=;
 b=cRQsxtKyzYp/5RTp+1HyvCH5lqDXOBFASSqkubfQwmne5syLXWJOV/GrFhTT8iTmE7
 VDXKX+nu1xjDV7d2Sqw39hhltVrHtnkynWDC9Z4j7A8/wSnDbLdkelIuSOe/pUK3aEAt
 nZMPMosNfaPu6JoVgktMrscW4dRKQsNeh29L87uBj9sbTU/GAw2Pw1u4J0F2gJkbQHH+
 jzesStzBPsLhlmUofw4PSQTgVwFZkCNNZaEZNMxScfpkYvwmllwAei2qa/Rd+6BirEoa
 JQxD4oj/04ukwpbTOEtUAaX3jQ7vhmM7zrPruMggv9aYJ9uyAioh1LchTFkxsIUs9AiE
 CHjQ==
X-Gm-Message-State: AOJu0YwDg9AfQv44Dv/GweGvUSSFlZ+0/q4BI2vWmflKukqrfrF5QGnk
 tTmUzeVBu0Y/1hgN3blRGrn5sCk5ipLW4MmnB+QUCMZmGUp+VXDeKWoxp2qew1vmfiA=
X-Gm-Gg: ASbGncvdprOrmu/JcBOFtAx9w2B4BKW85ihzihiUC4gxCJt2738l9YRQOgMJA+/CeUw
 wJQyXVWzXedjnPu04nGXXb7z5l4KncYyKEwdoyFbZPyeu3svtcXK9STiuusFZ/LmnHS4OHgXhnr
 xoI0fyXajwZeak0QSm+Zv+CQd/scl3DV9qJ+hwCbmDSsX8Ok4Y7no5EOQhGNoyp/zY3Jmfnq33N
 oGEVGyTS6/qr6HNVZkt4lQNrGsjlAiklJJBjqj0FcfMau20a/c9+0PaB7NI06eKVCU9IPb9hXRc
 2/erDykaDBMmmwtgmHsUV47nq7vBq270tye7qWkCtvdcQktDIbcLfhx+KHuzXXZtrgcTHuZQEbB
 C10Giah2FYOnNY/N5z1cqPPATJz1Ft34L8XciBdUJfjyVsLb/033PfQFASEBRIuaGY6XVLgVtK9
 ZXHedOy2XA2Q==
X-Google-Smtp-Source: AGHT+IEgOCSp4RdUdNOrfQ6TkDgLMkp3PqsA4nLnzADtxmzD21E02M/uSfflnMKEIcP/zuklK6pfDA==
X-Received: by 2002:a05:600c:314a:b0:45b:7a3a:32e with SMTP id
 5b1f17b1804b1-45b7a3a0589mr26128005e9.9.1756392700038; 
 Thu, 28 Aug 2025 07:51:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm76839695e9.16.2025.08.28.07.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 07:51:39 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:51:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: dev@dpdk.org, Olivier Matz <olivier.matz@6wind.com>,
 dsinghrawat@marvell.com, palok@marvell.com, jerinj@marvell.com, Laurent
 Hardy <laurent.hardy@6wind.com>, Edwin Brossette
 <edwin.brossette@6wind.com>
Subject: Re: [RESEND] net/qede: workaround for operation in Ubuntu-24.04
Message-ID: <20250828075135.77381013@hermes.local>
In-Reply-To: <3bbf5e67-8acd-47f1-90ea-405f62cbbc4c@6wind.com>
References: <3bbf5e67-8acd-47f1-90ea-405f62cbbc4c@6wind.com>
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

On Thu, 28 Aug 2025 10:09:35 +0200
Thierry Herbelot <thierry.herbelot@6wind.com> wrote:

> Hello,
> 
> [resend because the original diff was for the 24.11 branch]
> 
> qede stopped working with recent distributions, as explained in this bug 
> report:
> https://bugs.dpdk.org/show_bug.cgi?id=1379
> 
> For reference, one workaround is to disable all optimizations when 
> compiling the qede PMD with gcc-13, as seen in main branch:


Using O0 is pretty drastic and can have bad performance and doing it for
every distro will cause performance drop.

All patches must have Signed-off-by, so this patch will be dropped.
