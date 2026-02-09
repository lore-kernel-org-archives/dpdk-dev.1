Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F4E7E0D0
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:58:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1548A4042C;
	Mon,  9 Feb 2026 19:58:10 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id E5276402F2
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:58:08 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4359a302794so2106827f8f.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770663488;
 x=1771268288; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fX/mkvIYuXyBOd2JagYUUGwra1Ly1wrg80c7vFho6E=;
 b=EkJN4rL0KDz+Ky/fReHiJ419fAMJ2DAFwLLsRD8p+yIXByDdLBEU4PzH/TBY/n3X5T
 PhT+P8qHHkk8Oh3YMRtCOmGS9uxhKwbKU5Qx3l//wTLeTBKyoY/FXDgT8pY9+HFBQycl
 /hV+mI8jxZXJ1RfsfTcBDo4Sk2jNfQOGTAI0AhTPk9yjBPHC9yDlAQgypSbXIoxfTTAA
 5MWV9ZbWA+OVR8FdzJg8Ec4AyPpNLOtmYfESpa+QfR5ykSmwavhFEcM5xVMEs+yCEGbk
 5vEUWJjtxQzS+SqOn2f4F2g6Mxs88Sp3Tuyh5JqhyjIBjMeA32zlb8sHMdC+kNfK5K1a
 /v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770663488; x=1771268288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1fX/mkvIYuXyBOd2JagYUUGwra1Ly1wrg80c7vFho6E=;
 b=CFtsG3tlvmHc+XHRJaQnATUe8HAYnBDDZkgwub2NKFMWYLhgaivM6K387Wsh7yonAn
 uLojxAYL5pVgfwTOHyETNBqhq0b86cYsl+ofMUyjV+6+eYRyJkqhP4Q8mMNjTy+x+si8
 fno9XEKEMnu0PxncSEIXyNXwp/LiiqPvQbGOCgHHOj8UDw4ombRevF70394INz11+PP9
 iyVBemfZMSRQ7H/iiHLprwuMrBY2TcaVTu+QBXaah7NwV3cQnQmRMCrWOsr/QtQvlfnu
 r350W7d+XRGrNE6SPeuAGVG6cbZtqHSU4vC+zcWzvnlUcPTQuDdHhDUK4EQ++EQih50K
 eZ7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwP8vQApn8t34jb5NxbaqWkowq44xRcsNBgwn+dLUxkypFy3vog7JLrPQrQGu0z9M09VA=@dpdk.org
X-Gm-Message-State: AOJu0YzMQHOYlTtwBcziDBRQACxnOVv6bgI9GSB1HNb/qZFm4gB0r/t0
 OGwON3Wcy9Kf6x9gI+GgpGHB4L/h/wq+R5Ku8jibC/U/2C7hLzPGtylbMUaQLyeFM80=
X-Gm-Gg: AZuq6aKnB+73OzOtXcGH9TJzAckRdgMGIm4mFUN8NDrouzt2bAt3cvlaz94fPRoa+dl
 RrJqLzqBcbOBeobjyPZyKMkpnHf1qxMjDjRM6/dyAbvMJlLUeZd2+GH1JGklJYjsfXKtEuViOT/
 aix0LNYcjrcCbqwuMcR560lHOWEGGMlqU1wGlOAZ799ZhJRFB5hhEG2/Jr1q/L1B3x8rG49lMqt
 9LDdVtZx4G1Hsjyxfkp+rUsOqJBnOUj2eINDcuDRT99b1DJSQ9zcO5x1sc8lWhL3KsL39bBzz1U
 kQqtGysXYcg8wvNbW5htUAO2KktAGMEsOLg27GOgSNm2xQ44LqSSO5XAHIYPShRdl0yJ1WWT8dr
 H1IvgAl8Ondow/RwD9FtqF4yylHdwpDlvTXfIW4S2BXsZL9QfyWH6eZjSPUImVEqnYKHKnQdKZS
 jGHkfwiylsqCH5tTQlF1veLVrQ/9I+eQH0gv7tUiPhNyiMTQBcVzl/
X-Received: by 2002:a05:6000:22c4:b0:436:1517:aec7 with SMTP id
 ffacd0b85a97d-4362933efb8mr18231469f8f.17.1770663488375; 
 Mon, 09 Feb 2026 10:58:08 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-437699bc1cdsm14540366f8f.7.2026.02.09.10.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:58:08 -0800 (PST)
Date: Mon, 9 Feb 2026 10:58:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: Slava Ovsiienko <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Ori Kam <orika@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>
Subject: Re: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Message-ID: <20260209105802.13946890@phoenix.local>
In-Reply-To: <IA4PR12MB9763E82954C5054B794769EDD065A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20251117075407.9632-1-bingz@nvidia.com>
 <20260205084254.29f823c9@phoenix.local>
 <IA4PR12MB9763C7AB75A5B08D1FC30B0DD065A@IA4PR12MB9763.namprd12.prod.outlook.com>
 <IA4PR12MB9763E82954C5054B794769EDD065A@IA4PR12MB9763.namprd12.prod.outlook.com>
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

On Mon, 9 Feb 2026 14:17:27 +0000
Bing Zhao <bingz@nvidia.com> wrote:

> Hi Stephen,
> 
> Since there is no UT for the flow API. Such application would require some design discussions, and it is too short for -rc1. Could we focus on the change itself and try to close it? Thanks a lot.


I have discovered that AI does pretty good job of generating basic tests.
That is all we need to get some basic CI coverage.
