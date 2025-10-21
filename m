Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15820CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 15:11:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43113402DE;
	Tue, 21 Oct 2025 17:11:26 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 0E15A402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 17:11:24 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b67ae7e76abso4169039a12.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761059484;
 x=1761664284; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PtUdHTdrxL7pLGyweYSFb0gLSBZ/Dw7ge+JKRz9B7M=;
 b=UIKRCWD6Vzgfk4tJiq5FDNQME2+I7gwxyv9/k8CBPdUfOQBPk3FkWdwi/mhslO7oyN
 WYMCKTd4LDnLlyu0vJbbr7Fzp+6nhSRR9iQi8sBU+bMsCp1pbwG2lPMik14o6kotm2XS
 62jMqhtHxAQ4x8slc1iFUH2Dz1lU3Rq8T3NOMaNMjfBxD3AQShhUe9r6RB6UAnkAfrY7
 z9g9Vh83Hol70pHGTGRhShMIHswTCRNrcgsZ408aWPAQO/ynqAnoykVPVgaUPOlSVFim
 ud+gVWLlfMNva6qMUodVu7sw/ALLvVWnoHUnHYOWCKLu1a0vkzLhNNBanQNHEhsPfJUE
 ruyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761059484; x=1761664284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PtUdHTdrxL7pLGyweYSFb0gLSBZ/Dw7ge+JKRz9B7M=;
 b=m1NScTzqbO6xmmsthJUFSKRjzLTXuJS5mMJhsLGn1X0HAjuBQQjACk88+72c8NWGVG
 GqYXuDDvciF5KuMjyELjPyE1PjFoh/ZyBL4ZpfKMMrD5yB/5HR06oOyR/NBbmJjze3Vh
 wwhiwdZlZHztJgcF0cRjGRRWBg++LWXFxExhqNVKyALDiBsBZSD3+LJpsGSqOSUMC4K+
 DKsZ+t3Jb6+zIxMCQSQyG173RROKBUjisI5tQCsuXYrw5iJGs9MHCDp/Gyn/xB6fGVMR
 5iPPg9TE1TWGDzcoStBpW/kcCqHwpOgyC+4PmHTicaqfUMIyvV2xP1R12B7dz8K/PQhi
 p2Bg==
X-Gm-Message-State: AOJu0Yzqp+8+NtOE7ImqFkacVk7PUVxW/7e8Z7rwVN1MVELblueU5vAp
 FfhtMgmSTLJ24jS+QuWzDjj4xYO0TR2P6lVLGBSrDRkS0mqrKMAPwkdeQNYCIrRPQ+OVj7bmMmr
 7eJVQc20=
X-Gm-Gg: ASbGnctlgySKlyHwK6Rpc2LfiGsW+BhBgoguZj8vUNYeKZeIgK+kJlD80y4ZguNO2/u
 XuxCgCwDqIMyraclYrB5ZeH62QcEOPLDk+rTj81G2xBnx9jDXeq06etUOTP5kiTOnVeboBWd5R2
 y6PFrOeqk4H0Q+Qjnl9njo/2t1sjDEiwg6O1uARtLLqA4hqTfHcFBkXBuW69mBUjP0vWzQUEizx
 X9U/ke7nMaOLNLpDAbnAz4XimCAShf1P2YKfmsjvcA9iQ2blbIzsPLSvp2Llti+kUkiWT0YKBD2
 gpktOfp1ZS0SQIDUEGoAzkdk4bLyaC8xIozgUAqg8l2C/KW2LmUjI5LUP5hcRY+qGHg0hsZkIaU
 CiP2r5OeKTzLEjwlRMq3v93L5OgjLzI6KrAq9/dkC76IEwgLCCP9Rt6RbfeIyBkg189o+SFwTkz
 Ux0WHifRxeC/Z3cBGdwrRGCQwVeY5IbbmGebPgTuc=
X-Google-Smtp-Source: AGHT+IExwpYPEz75rXwLNIPE3T92uNj56pbfNc3+kcMXtALiDERlzJYmZxPb1juUrHTKmew6z3WvOA==
X-Received: by 2002:a17:903:1a44:b0:290:78b2:675 with SMTP id
 d9443c01a7336-290caf858c7mr177284305ad.41.1761059483916; 
 Tue, 21 Oct 2025 08:11:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ec14e9sm113060245ad.9.2025.10.21.08.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:11:23 -0700 (PDT)
Date: Tue, 21 Oct 2025 08:11:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v3 8/8] doc: update documentation on pdump library
Message-ID: <20251021081121.2168f35d@phoenix.lan>
In-Reply-To: <20251019165728.164929-9-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251019165728.164929-1-stephen@networkplumber.org>
 <20251019165728.164929-9-stephen@networkplumber.org>
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

On Sun, 19 Oct 2025 09:56:15 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The documentation was missing some of the API, and had some
> awkward wording. With the help of ChatGPT, update it and make
> it more concise.
> 
> Add a release note
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Recheck-request: iol-compile-amd64-testing, github-robot, intel-Functional
