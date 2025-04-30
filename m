Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759BAC369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 16:00:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07343402B1;
	Wed, 30 Apr 2025 18:00:00 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id D983B402A0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 17:59:58 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-224019ad9edso112452305ad.1
 for <dev@dpdk.org>; Wed, 30 Apr 2025 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746028797;
 x=1746633597; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTuqi9+A4Mwt8DQl8LFUgX5uevUTqTdJwARDMIKyz8Q=;
 b=N9K2vKPlozX6ZDTCQhjaJ71gFes6Daux/HJrFjK3HRkm4ZjN4fFdtKZQjazfc5ek+G
 TKKwtQTAW/uC3ffKc47eDB5kfKaRFDfkWyP0yLY0Gxajkg2/KFLOAGPcWL4r/KOqZ/KJ
 +kgCzsEtPQpO8W489do8OefX33dnxiAn7GbB+Ucip26cqMNDlpULtk1wPRODnaPl7yvi
 GO65u1gF7kZmuBaoNai6OLsZWFKpVaJ9cUtkD48opz/AYkj499oewoOiWOI2xLIjFh2A
 jdTWbGmW7IU/C+1zYKY8wehYQE98m/jRZLnDFIKd5xEIb9M3EYLvcGFFK4Ew5ChtukVV
 9dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746028797; x=1746633597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTuqi9+A4Mwt8DQl8LFUgX5uevUTqTdJwARDMIKyz8Q=;
 b=eeMjGsGhs7GRONWkzJpTnndeQV5t70bzBDPRyP+l2zqBzMyLMjI7ERduVSP3kBXKN9
 LK3DHMDMnV5k0nJVGMUa+m/9NmTXUA4bc0OPhXG6o1tYK66rN9Ry/1fm9LzwTmicBc8u
 7yFcVtiUhBAWOvfqzURwrmu/ehcMELMlXI+P6Utl2BOc0fUhox7UB2bxKCtVOgBm/teI
 fNqKebmzumkXjvclmL54OpMzsbYr1jhekfp2SqyJUyHUZDXK8a3XafDSydHRIdQ+DkBY
 TEE/OZjw0BCSwalf8TyzrgN49gJvWIbcRt1Vj+z3tuXuVbkYw+eezcph67uOrYC5ak/m
 i1eQ==
X-Gm-Message-State: AOJu0YwlaSDWRiuoWQlyYbluQxKIoCFA522E04aAcixcv6TvziCdophv
 LkQQdsPPcNTJbB1np4z2ZscFQ4VFxGr1sDswTlVcn4nIqdvKr5Z1vyy7sVjCgwQ=
X-Gm-Gg: ASbGncsYT3xEOng4BANNeAov2vGG0FlivzX4ztluvomQo30tgrOwpZox4fI4f0uZkoI
 ceV+Wx29jE5nHBs2iincMC000uZzwCwyNiAh8zmplzcUoNURLt2fpni1eUCK4YRPBlaDgj+bx8z
 HIC8kIV1ce+DrV5PfSRG/CTM8iphuGjEGCXwH8UVDabogIHLomeo13PHHnt+HUg2adauiXJf0wf
 nk+7DqaagYI6aybpz1WOf0TPd9aidyOzVHWA1irNfdXT8wJuUxrWmL+k3BopCUL4800zIiFDTde
 JlBZknoMy2+rdos0Rjsp33HfehVFdasGlBix+229Bqkatm0EshLNaoNKSUaU8esDqodfqI0cSqU
 dnuEY9ROtTw8Ul2qo
X-Google-Smtp-Source: AGHT+IHrRe9OlQLlppY83bVzraje5GdqorVltA4z4mUpEWoWFE4KJ2799cm8bmSC5gcvd7FjeOCngQ==
X-Received: by 2002:a17:903:2307:b0:224:910:23f0 with SMTP id
 d9443c01a7336-22df35d35e0mr60484805ad.49.1746028797348; 
 Wed, 30 Apr 2025 08:59:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dc2119sm123955655ad.91.2025.04.30.08.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 08:59:57 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:59:41 -0700
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
Message-ID: <20250430085941.0d4156ed@hermes.local>
In-Reply-To: <SA1PR12MB949189CD2B76C82E0C3F0EE2BF832@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
 <20250212163836.178976-2-shperetz@nvidia.com>
 <20250220103300.7148ddd8@hermes.local>
 <SA1PR12MB9491E12CFD0E551E742ABCDBBFCA2@SA1PR12MB9491.namprd12.prod.outlook.com>
 <20250317071121.4508a7e6@hermes.local>
 <SA1PR12MB949189CD2B76C82E0C3F0EE2BF832@SA1PR12MB9491.namprd12.prod.outlook.com>
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

On Wed, 30 Apr 2025 11:12:51 +0000
Shani Peretz <shperetz@nvidia.com> wrote:

> Hey Stephan,
> Apologize for the delayed response and appreciate your assistance.
> I prepared a document outlining the bug and its flow, along with the two solutions we discussed.
> I hope this document provides a comprehensive overview. Can you take a look?
> 
> Thank you!
> 
> https://docs.google.com/document/d/1LmMlJ31P1G77K0TGkBfXWz0DEj6zdprP0bG5p_wu77w/edit?usp=sharing
> 
> 
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Monday, 17 March 2025 16:11
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
> > On Thu, 6 Mar 2025 16:26:50 +0000
> > Shani Peretz <shperetz@nvidia.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > > Sent: Thursday, 20 February 2025 20:33
> > > > To: Shani Peretz <shperetz@nvidia.com>
> > > > Cc: dev@dpdk.org; Tyler Retzlaff <roretzla@linux.microsoft.com>;
> > > > Parav Pandit <parav@nvidia.com>; Xueming Li <xuemingl@nvidia.com>;
> > > > Nipun Gupta <nipun.gupta@amd.com>; Nikhil Agarwal
> > > > <nikhil.agarwal@amd.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> > > > Sachin Saxena <sachin.saxena@nxp.com>; Rosen Xu
> > > > <rosen.xu@intel.com>; Chenbo Xia <chenbox@nvidia.com>; Tomasz
> > > > Duszynski <tduszynski@marvell.com>; Chengwen Feng
> > > > <fengchengwen@huawei.com>; NBU-Contact-longli
> > > > (EXTERNAL) <longli@microsoft.com>; Wei Hu <weh@microsoft.com>; Bruce
> > > > Richardson <bruce.richardson@intel.com>; Kevin Laatz
> > > > <kevin.laatz@intel.com>; Jan Blunck <jblunck@infradead.org>
> > > > Subject: Re: [PATCH v7 2/4] lib: fix comparison between devices
> > > >
> > > > External email: Use caution opening links or attachments
> > > >
> > > >
> > > > On Wed, 12 Feb 2025 18:38:33 +0200
> > > > Shani Peretz <shperetz@nvidia.com> wrote:
> > > >  
> > > > > DPDK supports multiple formats for specifying buses, (such as
> > > > > "0000:08:00.0" and "08:00.0" for PCI).
> > > > > This flexibility can lead to inconsistencies when using one format
> > > > > while running testpmd, then attempts to use the other format in a
> > > > > later command, resulting in a failure.
> > > > >
> > > > > The issue arises from the find_device function, which compares the
> > > > > user-provided string directly with the device->name in the
> > > > > rte_device structure.
> > > > > If we want to accurately compare these names, we'll need to bring
> > > > > both sides to the same representation by invoking the parse
> > > > > function on the user input.  
> > > >
> > > > Could you give an example where this happens please?
> > > > Shouldn't find_device string always be changed into canonical form
> > > > in find_device handler?  
> > >
> > > The flow I was dealing with was attach_port -> rte_dev_probe - >  
> > local_dev_probe -> find_device.  
> > > The string passed to attach_port was the short version, directly from the user.
> > >
> > > So, to clarify - you're saying that find_device simply need to accept the string  
> > in its canonical form? Which means we'll only need to fix local_dev_probe to
> > bring it to the canonical form before calling find_device?  
> > > I tried it but then I noticed that there's no function that gets the user-  
> > provided string and returns it's string canonical form. The closest to this is
> > parse, but what it eventually returns is not necessarily a string - it can be
> > anything - for instance pci_parse will give you back a struct rte_pci_addr.
> > 
> > Not sure at this point. There are two options. One would be fixup in attach_port
> > the other would be allowing short form in PCI part of find_device. Since the
> > strings from command line are put in canonical form for devargs, it seems
> > logical to do it in attach_port path.  

What about if testpmd just did it first?

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b5f0c02261..a324225e26 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3413,17 +3413,18 @@ void
 attach_port(char *identifier)
 {
        portid_t pi;
+       struct rte_devargs devargs = { 0 };
        struct rte_dev_iterator iterator;
 
        printf("Attaching a new port...\n");
 
-       if (identifier == NULL) {
+       if (rte_devargs_parse(&devargs, identifier) != 0) {
                fprintf(stderr, "Invalid parameters are specified\n");
                return;
        }
 
-       if (rte_dev_probe(identifier) < 0) {
-               TESTPMD_LOG(ERR, "Failed to attach port %s\n", identifier);
+       if (rte_dev_probe(devargs.name) < 0) {
+               TESTPMD_LOG(ERR, "Failed to attach port %s\n", devargs.name);
                return;
        }
 
@@ -3435,14 +3436,14 @@ attach_port(char *identifier)
        }
 
        /* second attach mode: iterator */
-       RTE_ETH_FOREACH_MATCHING_DEV(pi, identifier, &iterator) {
+       RTE_ETH_FOREACH_MATCHING_DEV(pi, devargs.name, &iterator) {
                /* setup ports matching the devargs used for probing */
                if (port_is_forwarding(pi))
                        continue; /* port was already attached before */
                setup_attached_port((void *)(intptr_t)pi);
        }
 out:
-       printf("Port %s is attached.\n", identifier);
+       printf("Port %s is attached.\n", devargs.name);
        printf("Done\n");
 }
 

