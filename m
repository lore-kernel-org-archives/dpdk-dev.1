Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA85FC021B1
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 16:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D291D4279C;
	Wed, 19 Feb 2025 17:50:30 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 79D0D4279B
 for <dev@dpdk.org>; Wed, 19 Feb 2025 17:50:29 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so10302319a91.3
 for <dev@dpdk.org>; Wed, 19 Feb 2025 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739983829;
 x=1740588629; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDc7PU8+WJ2v8SXEmwT7MytLGcHo2n9g1LUwNuhvCLk=;
 b=LcZubv20zE7sY90d9LH6iCVaK6j6ZsZzWMWBSRsOZi+0CbI67bOzLNAEMrlpRIAeu5
 NJ2E2ih8eyvgJ0d3y+H9S4hTtmTD+Zde1Z6Vc+qJdgchLfpL1BAOnStb/Iu3fPpFsTM5
 zbavbm+meIGhTOOiwbTPOt/HnfFpumDplIGNzPjoPnVeruD0u9nmAbPJzlL0OZ+pKdhB
 nCqb3II5SnDFpeEnn9JOZtFnGDfQ73ShXsT+Qo2uLQhWkRIJLySF0Zlub9aHSDZz0pMP
 yYr7ZNAqIXXnDepGZ+fwivorYwSIpe8CSZ4aDDtuPzCdTZWVxXvKWjjdSav1z4FMtnpw
 C/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739983829; x=1740588629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDc7PU8+WJ2v8SXEmwT7MytLGcHo2n9g1LUwNuhvCLk=;
 b=LcvP+CSMKSTMfpuwAE7FRfKkLJsZ8IEBkjcil/FYG5U9yF2iImEAnbigKxo9K5U6hQ
 FWLwvnR3fwJQmjg6Kcl+gIZjeLfQMmIICv5PTCiq4Ax0TGeQLoUxahkxpCVR0mwZJoEc
 djNnwH6D4aTxTJbypxiHRIpRFy90nfaKTYrTHHyePLaliyAVre8Wf39D9+YzVPSECp+z
 OwltILyCn7o90y7cPp7jTixQr7Zcxwa4kD20Sg9wjbCl0voSDd0U92MmaBO+mflwR8sq
 cmVDkWipxWOR4nnCsyKqrBilfOYLsnSl5OKXDgTGKU2zEPVwFKDhS9j4qrQHObp3O/tj
 IDtA==
X-Gm-Message-State: AOJu0Yxh9D/yAViyefpk4OryFTC7BeReRyDWfIafm5S7/ksAuqkCJk++
 R5zt+B+u85MqwUndfllGTni0SxCWUYgtUQtl7FIREvqpExeBdmycOP5c3FTdvNg=
X-Gm-Gg: ASbGncu7jtL+kmdF0XakvyR24Wp6jtkzXk4tSUJcEUYJKuHYy8U8AjGErkGepseqzKT
 Zj7EOVSa55suE1HGWHx1rU35va6CffkogfoS59/kW3N1+gxU38xaRsVRyDZwcA1QFYtoBJe5IKK
 SXFDJwWQPLS8f471zay1V5It/6aGi5cMz4uVdHAcz+O/oQ2PFT2fwZXExaA4weJx7LewM+gaPvS
 U58Dj/zKKTbckPnzFZiB0UBQaKhbHsRx2z8e7l0Q7XSoP0Wcv6kS5YLgWdOnXAcab0bp2bGpMhr
 EeKeJY3LPsOC3IdxgKPoE7eq9qLKC7bka+jlbq9P+utFEspEHjxi+vRCy3WMJhLbfTU5
X-Google-Smtp-Source: AGHT+IEEv4Js6VRQFGiqK1ZhtOyX3Wr+VXZOT040VBy/QRT37tWQHdrzTY/RXTGMBy9MdgRcTtbnkw==
X-Received: by 2002:a17:90b:17c7:b0:2ee:cd83:8fe7 with SMTP id
 98e67ed59e1d1-2fc411679e8mr28375333a91.35.1739983828598; 
 Wed, 19 Feb 2025 08:50:28 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf9ab049fsm14279387a91.47.2025.02.19.08.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 08:50:28 -0800 (PST)
Date: Wed, 19 Feb 2025 08:50:25 -0800
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
Message-ID: <20250219085025.27f9a640@hermes.local>
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
> 
> The proposed solution is to utilize the parse function implemented
> by each bus. When comparing names, we will call parse on the supplied
> string as well as on the device name itself and compare the results.
> As part of the change the parse function will now recive the address
> to write to and the size of the pointer, in addition it will return
> the size of the parsed address.
> 
> This will allow consistent comparisons between different representations
> of same devices.
> 
> In addition, fixed vdev test to use the rte_cmp_dev_name function
> instead of the custom one.
> 
> Fixes: a3ee360f4440 ("eal: add hotplug add/remove device")
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

This patch set seems to transform the device name from a null terminated
string to a an array of bytes with a length. Not sure if this is completely
needed. Understand that C null terminated strings are a bug magnet, but
not sure how the PCI changes force this.
