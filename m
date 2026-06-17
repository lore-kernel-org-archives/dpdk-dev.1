Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98493CD98F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 20:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7271C40268;
	Wed, 17 Jun 2026 22:56:04 +0200 (CEST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54]) by mails.dpdk.org (Postfix) with ESMTP id 53A224014F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 22:56:02 +0200 (CEST)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5aa5be9ab1aso256106e87.1
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781729762; cv=none;
 d=google.com; s=arc-20240605;
 b=DsLEAuoIkYf1WKBhhGzfNKRR0ClxoeLewus9JnR2tcNP6DmBt0BgR51rlCUZiY78xa
 M/fh0c5wFyPtgBxSU7Vtc99oADyq5Hnnh3hqerV71yB6UgQG8ZnKJvBiOMOAXcyRAJQU
 yLzC3LQI+bq68JlbwnHYxHrIr3lLvsVa74c2knVxkYmHpcl191d02nvp12CCDReiiq6o
 zKrBhFZVZJHHGNwFwEkpn6UiRZKb3VkV18aDKmOz/7WxfzWNjlUBYSnWfp06JUnlfwjl
 YC/gG2Dwj7Vn/uQpgSaz9hdHIttkfgQF4SqeE2WW/3llxj/kaFCm/7p3iFaWY3uhThkw
 1z3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pZvhreaLCIyxhddlyCcKzQ3MsL1d7Z1jBkFTImAIrWo=;
 fh=SVsXckalWFsDifdJt7RfZhGNOrxDjuyf8YpZOPsnuN0=;
 b=GFQs23JB5O9Ghku9WlCph/FsuDW7p4x4HD35H7X216bLQdDp7vdFMWLNWdlAcukwN/
 lUbo8E5MpWgI1FDK9Me8TIYgHZ+nXrz/5hM9+MEvun+tG3bnJqX5SQFBKmL/+IYAvMAy
 /2+uyEAhM12GL76GsxoLF/pj+viC5ofhZ7p0afDhLhsXp283SMCHtVsxo64SFOO7E8jZ
 LtBPXeSKsvZfyudDipmaZdsH8P8150wY8Wy92cKyyv8DJMZ9JenR13mhT1MnGn88cjIe
 5OCr3SmuClnGA+VWu5Uww8No3rTCKmK+pmlWuFZK2F7J0n4qVBT2rKgkdWDRA9YbSLZ6
 L8Sw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781729762; x=1782334562; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pZvhreaLCIyxhddlyCcKzQ3MsL1d7Z1jBkFTImAIrWo=;
 b=n/rYOIX1FkQdtCAfKKehDp5pXXy+3nVG7rrERjl/sgtjymQ/IUnQVVMui295nyn7rT
 ycapHH3Ahecwl4azyzmf4QkjSk7XwzfgrVnWsVciFIZ+gn9O+LBQXixACZ2PtIxFDLja
 reUHNpBKSDtzDpbSs8Aplk0fVrdEbkTVv3S15lU2zGR1HCvXwduB+1NOcEPQQjdCnje5
 dbZ0zddqBrHVwS/5cw09ACHwiMFPEh4SlqBMM6Ab7svDTcI7WAJecoJk9Hd0+HLKI7gP
 /dsRSwr3+kpULe9/s/9FtEqJQ0GJcJ5rmeYm96YHh7iXWZjx647QwF4IzwRCcEw+Eggy
 4y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781729762; x=1782334562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZvhreaLCIyxhddlyCcKzQ3MsL1d7Z1jBkFTImAIrWo=;
 b=E+j2W/FerAJB8rRLlJ31w6IcGXJ6iL6NMKcIN+E7ABPTa1fQpYY9RJBb+cbugNhEgW
 CEU1fdYiGkhoJFkoueRkf7d+LT3b69RTCjkcbRID88MkxwZ0aYOta8ecBbOXIGbuiq9G
 9O8Er3wMbfTWZJ92RAxZAHe6wO3QJUFqm0hG3H3YzTd2k11UpEcC8Sf7clcunVIWTGGJ
 A26uWYZ3txxBv8SKdjZOSbU1GCSFcORgXh5KVimwXagcsDnXLzpCSbOUbWlwBCkfL2ow
 yTHmxKjTF+OYJoKvs2AUtMwVBmRtfFUMkk1G+j9DRhR3pdLuFhZVuJuwyYFAzyaUcxn9
 xSMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b1ggEO5+XRhm39HkYjUdgaN7LOMOK6RCqkbhJOToCNZX8Q6FIzL7Si3xJnjQJ8jro4mY=@dpdk.org
X-Gm-Message-State: AOJu0Yz8Kcfq3dP4W4B//om86l3xddo+S4UITvjbbfVIib+QciJo4arb
 xpbXqxF1bV3+cdPf802OT6KK4TWfn42jR/6ipZH4WKehoY386lvdJhPq2cVBOnPovKrQ0joWlf7
 cUnN1dgdGSqDFd9o+bB/7Qdw2o+ERbLY=
X-Gm-Gg: AfdE7cn0ej3jNrE69S66TQ8sJcoE35VtymSXmS3xjzpoj87PNE554QOY97Uj5zWnnzn
 s4pZqSA+zeoS1bG0iL2DHtvSt9yfxjgFqn3yDEVTAICKiIig2FfE0VzHBAcG4f/EV5aXlUQ15GV
 ACYdbNq/piXzFMDfLURg2ejJgY4YuijSb1Cufe+OFBp8xxsTHyHdITZ7XlplOhML4h4+J1iCJsW
 SSnbNZIpZDaSvHqKlLi5nsHf6zsvXqONX3RKgz0iGYi3fuahytHvgumrcHYHK2NYl2pIwTtkLNk
 bsy4gTAXiCPnHb/pTqZ//mTixEBUAw==
X-Received: by 2002:a05:6512:2c8b:b0:5aa:8824:156b with SMTP id
 2adb3069b0e04-5ad4dacadbfmr198191e87.47.1781729761371; Wed, 17 Jun 2026
 13:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260518175424.253600-1-abailey@iol.unh.edu>
 <20260617155748.59724-1-abailey@iol.unh.edu>
In-Reply-To: <20260617155748.59724-1-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 17 Jun 2026 16:55:49 -0400
X-Gm-Features: AVVi8CfLlyTDfOVv96c175XX2xS8u-wS9qSQTdH_dDuhnOZ_fmmdFAlEGsdryNQ
Message-ID: <CAK6Duxt3ZSCrHQyFp-n1OrEiWH7-4YNPzC8LP_U1HxvbouSwvg@mail.gmail.com>
Subject: Re: [PATCH v5] dts: add retry loop to trex traffic generation
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, lylavoie@iol.unh.edu, knimoji@iol.unh.edu, 
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000832b5f0654794994"
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

--000000000000832b5f0654794994
Content-Type: text/plain; charset="UTF-8"

Looks good, I will merge to next-dts this evening. Remind me, it was Intel
NICs that were having link issues with TREX before you added this retry
loop, right? Thanks for the fix.

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--000000000000832b5f0654794994
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks good, I will merge to next-dts this evening. Remind =
me, it was Intel NICs that were having link issues with TREX before you add=
ed this retry loop, right? Thanks for the fix.<div><br></div><div>Reviewed-=
by: Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com">patrickro=
bb1997@gmail.com</a>&gt;</div></div>

--000000000000832b5f0654794994--
