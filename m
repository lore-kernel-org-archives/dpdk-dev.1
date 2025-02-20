Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EB9C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 18:33:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9BB94026D;
	Thu, 20 Feb 2025 19:33:05 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id BE85E40263
 for <dev@dpdk.org>; Thu, 20 Feb 2025 19:33:04 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2fbfe16cc39so2606048a91.3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740076384;
 x=1740681184; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zn4sxNgdJT4A4HXo7xLHoUJGmPOXCigs6tePjGHmUcI=;
 b=Gzyv3pB+wMDt5ZcvJzvIS2iKlK9kcDvi8g+OJ/pIRXeTtBp1NrYuwKppPZcBjQ+1UB
 +jv/kE6vHpxnInbA4mL8bCpagQbFHJX+mUE3dQwC3CPbz13r5ZbK2W7+EJXfUDxbmSEk
 FhGK1OoCcbD5psvOKKdYNjthx/pbq3HY0We/L9c71Nb+OWaJFtRXwTQ8TSzk+RYE72WD
 tLyeKDdUXiwr1efREcS75E4JXAcfMXTIaHYL6UEoXrmx93BtAODQb2KTCfrtYmXY26GN
 skkkG9kWcSqOOYqID+TTb6G2xpAyTIGBDXWhrAEDKNR5ANjeNX17LO/LcALawWdzS+Ql
 oyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740076384; x=1740681184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zn4sxNgdJT4A4HXo7xLHoUJGmPOXCigs6tePjGHmUcI=;
 b=VD6ua3bb9sxaeHwGK7GtcRrIiEOtqz/t58xts3EdAHv+enZ/cTwnYGC2me4nGBwtuP
 K5oToEKHwWs5kzXzDNHZVXCS8KdNggQC0HALyFVJKCZY+bvQw1oBDWUePkS0ghDdu+x9
 gnGZdccxc0q+TXAMmyxT6Pt9AZhbIydQ3Cp9276ZuBR5i/sLC1SRwQa1Mju387CgvnrB
 Ume+6v5HImvDOqxqnmsRXNgy6mfOVGo8Tke6v+2jh1RQNlCjic0ZfWhhb24CbPSpxmdP
 zi0StbzFXgFWQfKgvxpUmVrMpLsBOy9XXVEp5MXRScsOCteiOIhE4et7Lv7J9gg9Aua+
 eOfg==
X-Gm-Message-State: AOJu0YzGXHPlBzwM0l5HBvLUeR39DGog8zGQxEXxoCt/n6KSn3EiT9Pn
 FtqaD81YeZYQY4ZaHR6uVu/Q2QCMUsQsTj90YwXy49qcSEEeXx3yc46qyfFuQeU=
X-Gm-Gg: ASbGncvu39IHW2K7w0bB8mTdsaRa0wU852ZP8n6g3NvdBnHvc51MNYgqqySUil2LXdn
 H1Iui9x9x1tFbRACfHRE5VRPs26SbO9cl53SVBVfd+2wm46+TKdGkJGkw1WQklDLSbcGE5lSwU9
 fzO2wlfOO8JCrArQeXtuzzvIgnyv+yRBkS0AR78NghLR2jkVwjWrkwn7HP7quDiAq+tjgGTdcHJ
 WZ7P/pvEj0fyn1Z/rf6laZN4P/f58nuLoDbxPPnx5TjDBR8Uj8ZRtydm6OfIbehJDs689ou+Iwl
 rFpBN5uUt2pQMjmlhl8g/kERjduxkx4QG2XKxK7ltJa6brTwfvRIjf9pkoTbFRltGM/O
X-Google-Smtp-Source: AGHT+IEmo7rU3u7iIYCUIN5QTQ+oghWig/PZI/jQ9JIv081rYEr78Qq+qBIgYx3BLo34s7laBV1Pvw==
X-Received: by 2002:a17:90b:2e08:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2fce76a610cmr305194a91.5.1740076383802; 
 Thu, 20 Feb 2025 10:33:03 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc7e9325fesm8685245a91.46.2025.02.20.10.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 10:33:03 -0800 (PST)
Date: Thu, 20 Feb 2025 10:33:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, "Tyler Retzlaff" <roretzla@linux.microsoft.com>, Parav
 Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, "Nikhil Agarwal" <nikhil.agarwal@amd.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@intel.com>, "Chenbo Xia" <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, "Chengwen Feng"
 <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>, "Kevin
 Laatz" <kevin.laatz@intel.com>, Jan Blunck <jblunck@infradead.org>
Subject: Re: [PATCH v7 2/4] lib: fix comparison between devices
Message-ID: <20250220103300.7148ddd8@hermes.local>
In-Reply-To: <20250212163836.178976-2-shperetz@nvidia.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
 <20250212163836.178976-2-shperetz@nvidia.com>
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

On Wed, 12 Feb 2025 18:38:33 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> DPDK supports multiple formats for specifying buses,
> (such as "0000:08:00.0" and "08:00.0" for PCI).
> This flexibility can lead to inconsistencies when using one
> format while running testpmd, then attempts to use the other
> format in a later command, resulting in a failure.
> 
> The issue arises from the find_device function, which compares
> the user-provided string directly with the device->name in
> the rte_device structure.
> If we want to accurately compare these names, we'll need to bring both
> sides to the same representation by invoking the parse function
> on the user input.

Could you give an example where this happens please?
Shouldn't find_device string always be changed into canonical form in
find_device handler?

> The proposed solution is to utilize the parse function implemented
> by each bus. When comparing names, we will call parse on the supplied
> string as well as on the device name itself and compare the results.
> As part of the change the parse function will now recive the address
> to write to and the size of the pointer, in addition it will return
> the size of the parsed address.

This leads to more complexity than needed, the layering here is a bit
of a mess already. Way too complex as it is.
There is complex nesting between generic bus code, pci bus code, kvargs
processing and drivers.

Why does the PCI code need to be calling generic code for parse.


> This will allow consistent comparisons between different representations
> of same devices.

Not a fan of how wide this change ends up being. Would like to keep
it just to PCI.
