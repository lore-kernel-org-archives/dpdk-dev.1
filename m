Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A026CC83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AD33402F1;
	Wed, 16 Jul 2025 22:16:19 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 06010402DF
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:16:19 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so227123b3a.2
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752696978;
 x=1753301778; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kztxEfmydskJVlTHAU+JIpM6yZf77p1/J50ZiWS0jw=;
 b=EwrpF9KvXrApS6uA3xckCCjVvI6UnAL2mHQEc12/vss0TM2ggaXGsZKglsBreOeMXN
 D0HwGIJUiu3wMAPan5XLO96Vg+vcXasdr0AoNGMhetQbj1xDDPuXRL6D/PqfoM8cAIdf
 isY9nhXCeEVkgmL0Uxg6YbZZ4F7l/EbcSyvSFzbrPrp55BtHtrpXkDuzeFTPMFHvgdro
 rX/xS3smADe9PVy8M+xycs4JapHTBiVCsIByeC+sNVKrxMv28dhNSfbomVfhvQMlfS9o
 fpgLtUqPod/n6sPht3hM9lYUn4zlwxnu4tKNutb3XYiGrIza8x4lh2wDJVZb8MuR9Itn
 eowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752696978; x=1753301778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kztxEfmydskJVlTHAU+JIpM6yZf77p1/J50ZiWS0jw=;
 b=C45qYux6nTjrTwwGmrBUFPoIgJnrP6m8t4I2qQLrAdPW+DpgawiByl1KXP5g5x/pQd
 luclPy2awQs+chSCvgPK0MkMSbt93jeNasGy9/mqwSTyYV2tCC6Bt6lnWYJbnDAqFJJu
 HqCJ9wxeH6G7PaDyGtTtX+Oxzhmr2UlnPj1kJXXScQVonZkeY1+F62anHyjJwebC9ql1
 0hQ9PXP6FqKdv2QU3Ic/FoJOcL6QD5OJWvCPN5fX5/VHdMI2g8XIve8R53t4z34pYQMi
 xG8BlmLedSBIjwh1Q781V8v4jQcDd3czwysXwPJYPGfVg0QCwmwK3FzNAKaS+aYKKfGb
 9Djg==
X-Gm-Message-State: AOJu0YxiXWdsxQrhs6O1zXqQmVKtpmpyde43wEv6g/mg28W1uVIOWV54
 /fREPI2tzQSDudKgFojIm3AB4p9zEpiuf7IZfDPOB5RfS5H48k45bma4FBmD4nGoN7HiRg4nGbq
 a5iv/
X-Gm-Gg: ASbGnctVzNjq4AD0Fh8fsGYNuIuHmlapM0zRkSdOXd1q5b0PZj85YnpQbprH86Wx1GN
 0AWz5swa51YZT8gBpndz8yTnV5HFRUB2RlnVCdMIOoqRUshk0qKa8QJo9RektCJwv0lLjeWwilI
 VtThIWhTevsNIY/dm/nr1VZO3mTZVZ7pBnTuq6j2OXFuSxVA1vRQr9ccJnte5ZZO7B63s7h6cis
 UhHYo4x6O+7BVr+PP7wcqY1JLObpKmq5TVgSvvdrgQsniDE2TvkVfcWPnvnsdHZyd8utXMQVHTE
 ZBaUN1Bz82iqMidFpLS/byK1OpPb6pxZdNY0lmgl0XRi0ZMngPilwj/eMwsn0vvAfRlgNc/fSdz
 /WEoSZVtfqvqn43wbRFqfdjiOnOLvcU4d8DSAEKQaoSbLAVm+WtR1tSTbGzsRGAh+4Bm6gEl+jP
 QMYQCX5o3xwA==
X-Google-Smtp-Source: AGHT+IHnJ0pFvUrMkvj7jn67OmSaptJVyTVAaog/Jc5Lv89RQdFBki6oCva4dCfnNKoDWn5FrImy3Q==
X-Received: by 2002:a05:6a00:2189:b0:748:68dd:eb8c with SMTP id
 d2e1a72fcca58-7572487561emr5087893b3a.23.1752696978033; 
 Wed, 16 Jul 2025 13:16:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe579b0esm14231805a12.22.2025.07.16.13.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:16:17 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:49:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250716104942.7285b856@hermes.local>
In-Reply-To: <20250716082930.83026-3-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-3-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:19 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Add setup, initialization, and logic for tx and rx queues.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

Buried in checkpatch warnings are some spelling errors here:


WARNING:TYPO_SPELLING: 'unsupport' may be misspelled - perhaps 'unsupported'?
#5037: FILE: drivers/net/sxe/pf/sxe_rx.c:1451:
+		PMD_LOG_ERR(INIT, "unsupport sriov");
 		                   ^^^^^^^^^

WARNING:TYPO_SPELLING: 'signle' may be misspelled - perhaps 'single'?
#5323: FILE: drivers/net/sxe/pf/sxe_tx.c:40:
+	/* Offload off and signle simple tx code path < 32 use simple tx code path */
 	                   ^^^^^^

WARNING:TYPO_SPELLING: 'Signle' may be misspelled - perhaps 'Single'?
#5634: FILE: drivers/net/sxe/pf/sxe_tx.c:351:
+		/* Signle transmit */
 		   ^^^^^^

WARNING:TYPO_SPELLING: 'enought' may be misspelled - perhaps 'enough'?
#6069: FILE: drivers/net/sxe/pf/sxe_tx.c:786:
+		/* Clean up enought desc */
 		            ^^^^^^^

