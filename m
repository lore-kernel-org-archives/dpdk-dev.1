Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B745C282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 14:11:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CD70402D1;
	Mon, 17 Mar 2025 15:11:26 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id D01E6402BB
 for <dev@dpdk.org>; Mon, 17 Mar 2025 15:11:24 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-225b5448519so78665265ad.0
 for <dev@dpdk.org>; Mon, 17 Mar 2025 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742220684;
 x=1742825484; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4fyQsf2mElh6DXrWqAWiRtOVhyDfgJUiA8O0sniwTU=;
 b=g6BkywZvD3E3Nvvl3FdkGW15pRhk3FVKbFbxyOFFGQDCp8awSRd15V3p6WdIxqXEst
 hkWBKwK/VOWsKkuTI6x2WrpGK1haXi7ZA7SBnuvj1QsWoHWqHQScfp0kxqYPNeXUCCuz
 uj+bxqCAmLasNZ1Mk1hnd2mYGeMZm/bDHj+i2Zs9vLB28xQpc/ivDpUCLUz/wtmheXa8
 TPEMb7kuAWKHim6J1jGNwzUvmygG5GzyQJynP438sDub3yy8pomxiYzOGQWYuTqzHH5D
 gVjcuikqBMvOnnamlgWMFB42EawEeipc7OQzmDz6zKr0zh9h25lJFp/U8A4krGLmR5IT
 KdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742220684; x=1742825484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4fyQsf2mElh6DXrWqAWiRtOVhyDfgJUiA8O0sniwTU=;
 b=YR33Wbim737bIbMFn9LGzt4JdE7NdZnRSjjkGjQ6yC4eikZ2Ua8TH0KS03L3wC3Njd
 0GH3HDuM13kX2DAkz6vcpJIN3pgQI66Us0ZSnIIMOjE2qLsh86HvofaSwhr9uYWM96Ke
 g+B0mPiJIq1EVhzAJkHrn9ZsVuH//78kKwp9Dzd5OBokwj2j+1q6rOguHj/DTBUMTNYU
 ZcWIIzmo7g7CX+zHrxsEeT81oFdzkjbtcoMAx9JJsbP5vz0gr9Jt5TlTsgy7Md17SS6D
 NaNMptbzpjaA/Ykyzn018pZzr/Z0/NrA3LlfSKsY6Nm+HsD581tglihC90DK26TRluZR
 ovsA==
X-Gm-Message-State: AOJu0Yw6FtJ4E3b8V1JSohvlRSU6AYU3bkOqKPJ7yZpXrmlxhqlUnfm+
 s8jdwTHwIedzGk8+rEkgnRPIm+/4jWEuetSvFesXzKwtyOwE63P/tYpAi4Pbq3o=
X-Gm-Gg: ASbGnct/6xfowrDjm42Rfv8JAzK5/yGfO0Yb7PoXK4Wxj4eSAKMj7IZGcKxDy/kqSBo
 FeayUTHQnJUK8mKs2kG9QLMIt5z6Z1ql4lhP3IALLzJExaj88aglmKCV2bICedLnHDlegKM/Zgz
 PGCs1Mz6ybYI8oM8B+mbSwTMMcFpT71Na1Oszx5rbK/v4a72Eg1j+2FEJu2pqkxaE5Gn9PVaEn2
 +8vRQwlDS61Md7nHbs3sATi8wgCxcS6CyfsPcKBD57fDxszGziOwebToOdK7xg2jRRambhExHvo
 BtiFXcr/Z3AlbYgv3vM+KUSbB0yREGGJvFWpDAPZviaze0ET6JTzN0QTr6Ovy+3rfE86Q90F7VQ
 I8TbJM4M6ZocwqeOWOkJooQ==
X-Google-Smtp-Source: AGHT+IGj3/v15knJrpjqqkNhW0GQ9J3PX6AG4DEKCTn9FhYQvxnjoMEyYgIfCM7hT6SPy3seHrGvhg==
X-Received: by 2002:aa7:88c8:0:b0:736:64b7:f104 with SMTP id
 d2e1a72fcca58-73722338721mr14047745b3a.5.1742220683549; 
 Mon, 17 Mar 2025 07:11:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371152949csm7858018b3a.17.2025.03.17.07.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:11:23 -0700 (PDT)
Date: Mon, 17 Mar 2025 07:11:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>, Chenbo Xia
 <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, Chengwen
 Feng <fengchengwen@huawei.com>, "NBU-Contact-longli (EXTERNAL)"
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Kevin Laatz <kevin.laatz@intel.com>, Jan
 Blunck <jblunck@infradead.org>
Subject: Re: [PATCH v7 2/4] lib: fix comparison between devices
Message-ID: <20250317071121.4508a7e6@hermes.local>
In-Reply-To: <SA1PR12MB9491E12CFD0E551E742ABCDBBFCA2@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
 <20250212163836.178976-2-shperetz@nvidia.com>
 <20250220103300.7148ddd8@hermes.local>
 <SA1PR12MB9491E12CFD0E551E742ABCDBBFCA2@SA1PR12MB9491.namprd12.prod.outlook.com>
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

On Thu, 6 Mar 2025 16:26:50 +0000
Shani Peretz <shperetz@nvidia.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Thursday, 20 February 2025 20:33
> > To: Shani Peretz <shperetz@nvidia.com>
> > Cc: dev@dpdk.org; Tyler Retzlaff <roretzla@linux.microsoft.com>; Parav Pandit
> > <parav@nvidia.com>; Xueming Li <xuemingl@nvidia.com>; Nipun Gupta
> > <nipun.gupta@amd.com>; Nikhil Agarwal <nikhil.agarwal@amd.com>; Hemant
> > Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> > <sachin.saxena@nxp.com>; Rosen Xu <rosen.xu@intel.com>; Chenbo Xia
> > <chenbox@nvidia.com>; Tomasz Duszynski <tduszynski@marvell.com>;
> > Chengwen Feng <fengchengwen@huawei.com>; NBU-Contact-longli
> > (EXTERNAL) <longli@microsoft.com>; Wei Hu <weh@microsoft.com>; Bruce
> > Richardson <bruce.richardson@intel.com>; Kevin Laatz
> > <kevin.laatz@intel.com>; Jan Blunck <jblunck@infradead.org>
> > Subject: Re: [PATCH v7 2/4] lib: fix comparison between devices
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, 12 Feb 2025 18:38:33 +0200
> > Shani Peretz <shperetz@nvidia.com> wrote:
> >   
> > > DPDK supports multiple formats for specifying buses, (such as
> > > "0000:08:00.0" and "08:00.0" for PCI).
> > > This flexibility can lead to inconsistencies when using one format
> > > while running testpmd, then attempts to use the other format in a
> > > later command, resulting in a failure.
> > >
> > > The issue arises from the find_device function, which compares the
> > > user-provided string directly with the device->name in the rte_device
> > > structure.
> > > If we want to accurately compare these names, we'll need to bring both
> > > sides to the same representation by invoking the parse function on the
> > > user input.  
> > 
> > Could you give an example where this happens please?
> > Shouldn't find_device string always be changed into canonical form in
> > find_device handler?  
> 
> The flow I was dealing with was attach_port -> rte_dev_probe - > local_dev_probe -> find_device. 
> The string passed to attach_port was the short version, directly from the user.
> 
> So, to clarify - you're saying that find_device simply need to accept the string in its canonical form? Which means we'll only need to fix local_dev_probe to bring it to the canonical form before calling find_device?
> I tried it but then I noticed that there's no function that gets the user-provided string and returns it's string canonical form. The closest to this is parse, but what it eventually returns is not necessarily a string - it can be anything - for instance pci_parse will give you back a struct rte_pci_addr.

Not sure at this point. There are two options. One would be fixup in attach_port the other would be allowing
short form in PCI part of find_device. Since the strings from command line are put in canonical form
for devargs, it seems logical to do it in attach_port path.
