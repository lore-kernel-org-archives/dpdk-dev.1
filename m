Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5469D10F284D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 16:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 886B540E49;
	Fri, 27 Mar 2026 17:15:10 +0100 (CET)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 544B2402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 17:15:09 +0100 (CET)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2c18af885c0so877673eec.0
 for <dev@dpdk.org>; Fri, 27 Mar 2026 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774628108;
 x=1775232908; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwvRoBH2SifNfiN4eg4JJbsuScAFhXP3a0fQzcH9KK0=;
 b=1EWUUc3EELII/B9ANSh9XuUibW0xGtjOTwkfBhJFCVRc4pmOa/dqQCEvNVcW2OF/Dl
 9Lew0N7MVjgr/JUEeDzO4TXBVzukNIFzjewhiphX6ADF6i6MSE8gBr4U5OlfKQsuS9BP
 QKyxwSIhDgR/WqVpVVE/Zcb7m8aT4ELREr2rdGFQrqphkBBzoCPUwKJH3euCeAuThaQ8
 Ljj6UDRGQtP/vIB+MrYKCKStchhQx3Ik3JUpidlasEBipmwzstLsL8oaCTECo0/Kchvf
 oV2/Clbykk8jkLyZPWRE3VrGsIeRST0FtbMZo+j1tGfWQD0s1d1SS9QHpGwhziBVmThr
 qIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774628108; x=1775232908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HwvRoBH2SifNfiN4eg4JJbsuScAFhXP3a0fQzcH9KK0=;
 b=GvjlMxU3TJkh1TxWHKnSPXaT30lQJdSA2beXAsC6YEzxwO7GF6m9PWCKRCA6sIyX2p
 5dAxjyb6Wo5S8zk88j4B9D1kiJ9XuHPR1ox77E9KBRSPqDS0lLjioXYu+NKkzwO0ygGt
 BvlAEA4KxfQrCqe1zZZYRONSH+eEdxFsLc8ZKJblftj3mLpfn2ZLm2EBrFWFltWNUzYE
 VGtKfmBL/5fJ1Pyt4REE8uyu5j4nwggfMfXtuQ4ay2DWfhl0d/QRag3GOyXsrfldl8ia
 jrB4/Fl9snQ63DYXcFf1Q/VAF9K0ONV+zIJR0w7pEoWos1p7kx6TIKB8RrXYV0wvxn6a
 BRYg==
X-Gm-Message-State: AOJu0YzpcgK3QZ9JPGdqozcrXyKo4tK0N3/LSIJUy5Oj77fGt8m1wawF
 H/ljq5wPxPSg7W5u8XEZTDaIl92M6ulDHxRkmwT1eGzpdaQMCENXS02IBQ8V4rT9k8s=
X-Gm-Gg: ATEYQzzLrNgUZlmpp9g/3rayQ0km7qPLzi6ijxuksvmXIeMQoxufkPT6/AFvrHmH179
 zXD/swDxfT+Sa0aRjnbXVntlO/4Mz5WsxeKwIcE5nET/a+sYX9fhfegF90rkvoOMfm+WMO7tSzq
 PHhaIj/3NHohNgaYbt0/MxqbtzFHRaDREpbWVvBs4BJ6G4ZTx2fXuGLEqFq9FF72pIJqCAx7aqv
 r3Hcuj+t906zdgd8oIQ9SGX1u/Dq1z336LutOfXJskv8Mg2UTRm00wiC2pXqanyhENGWUoEqYWK
 NhADSDfOO8KYb2MYFPdKzp7V7QOGMClLDefsOeP/RqlUz4L0JwRgcmbZw1l2ZN3E5mheDsK1vQm
 ySiNqNEo00QUMr7L8Ezjx6LP6rvhIdMKpzy3ZdAo9wMVj/dz5sokdS28WEK5o8AB9ewk0MZ/665
 gcS9TNUmA2kx8AYR8uVG0kjVGpE5P1wa01/7Y=
X-Received: by 2002:a05:7301:1e86:b0:2ae:5ffa:8da4 with SMTP id
 5a478bee46e88-2c185ce844bmr1917189eec.1.1774628108073; 
 Fri, 27 Mar 2026 09:15:08 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ec2690bsm6608453eec.5.2026.03.27.09.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:15:07 -0700 (PDT)
Date: Fri, 27 Mar 2026 09:15:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH] net/gve: add passive device-requested reset
Message-ID: <20260327091503.3a056c68@phoenix.local>
In-Reply-To: <20260327002038.3386577-1-jtranoleary@google.com>
References: <20260327002038.3386577-1-jtranoleary@google.com>
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

On Fri, 27 Mar 2026 00:20:38 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> In addition to application-initiated resets, during normal operation,
> the device can indicate the need to reset by writing a value to a device
> status register. This patch introduces an alarm that polls the
> status of that register and informs the application of the need to
> reset. The application is responsible for registering a callback that
> will execute in the event that the alarm discovers that the device
> requests a reset.
> 
> Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> ---

Since not a bug fix, holding this off until 26.07 release
