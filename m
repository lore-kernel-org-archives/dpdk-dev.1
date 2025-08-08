Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6670DC87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 15:32:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3FEA4065E;
	Fri,  8 Aug 2025 17:32:11 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 3E2AB402AB
 for <dev@dpdk.org>; Fri,  8 Aug 2025 17:32:10 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-459e3926cbbso11416365e9.1
 for <dev@dpdk.org>; Fri, 08 Aug 2025 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754667130;
 x=1755271930; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNdUi8wT8m2f3iq6zFeD5X8EcIAM/gXI/BQirdIXUsE=;
 b=nz9jh+7AsFCKNJQThhdnwhjXfGZjUSLRi+UxFHxG7AwEtiFMg34/aljc3tbGs6bzmK
 JP6VkMJsSt5bmr1Tq33wpFUXl3sdKMRCYiqS0Y1EFObfXTqDK7ruGZYM0T5/xgGzu0U4
 PyEryVv9tXVl2flHFRMzxlGHphG8eQn9MwO++qAbIxVL9SiPT0j3gs0RmkFIpdzHZUOA
 ux5K6HONReqtEJiD/GggtQmBevrtsyJdl/K3jZd+XU6M/DwdH+eZEo2PBkMimdW+GsEX
 F2RblDRfY5fO3QlXydoZNiGdsRvI1TDsq3jdtmFajg3LEHk26pnXZBkWf5i7zvl5Dlsr
 IrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754667130; x=1755271930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNdUi8wT8m2f3iq6zFeD5X8EcIAM/gXI/BQirdIXUsE=;
 b=D/SuqdBXrgAg9Kx1sKJyapvrZHBQSKMTze183GjLgwkH9IS5VY/MoLOPsK9gnX8Jdt
 1fVk03OhB5hT9HgJ8ifhsEmFgrKE1nwQervZZVAN8EOzXLkugwr2jOECpkZBFlQz4lJ8
 AOE3dmRGFeiH6eLQe21voTjTER5DPSwU815cCPVD0l2RdB47jXRmmSr2E8rMYOxgaMEa
 gReLsSd3fXap3n8dridsUZvjUJz062c7dAnHVGH5DIv5795oGBVB1jP90OqbJbcXzUDO
 vcV4zBZuJdOcPqr9HvpD39sCLNtj088aoPJYWDVPp2jMK+bZa0uG5xjhsMLdoakhyU4w
 TXWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe+Q5keRS3Qa3z4q/OC5IN/GNjV0dt61lTSCIr6lbf9/FPJiK+d6LWbmQPgQAAgQFLSYQ=@dpdk.org
X-Gm-Message-State: AOJu0Yy4A2ZOmSM5MkY71FqlQMor4GsK7TDSFd4JN3tXpBoqzTEtU2q3
 5JVzrc+HJ9A9vRQcAotyEQaOhdfoTKJnAszESNY3SYeTCzAlzF+2ayjEirhrGrV0TXI=
X-Gm-Gg: ASbGnctG/2Emz/BEGybgAo54uShSxUS4TReR0JjA33+1nJopt/dTIqKA6vApa1P3HK0
 KBXyaASbzjh3vRQQyKD+Wsk7ClFC9/dONWrzjJ+6CUmIcsWbyCqdg2KVWwnA8yGjn6lx64tBoXA
 +VVdCP9RGnO/BtePuDEE2BWqGtp3yESHH5z60GsGJrzYNpbV9iIgeNRksQA+EATdUOFVWFuQU2G
 WnDfMLabhN3UaMKn5tsJ3vJMlourQHwQZorovO+7Xq7YPjCJ5ZqCSyTpDUPy0l3O32c67aYZSfm
 guY0daw+lx/iMp2jutsEtI2lVaQWy+TAkEEy7jHhsXO1YMPwuc/WNPWSHMhaVcAGoOAfvQaoOdb
 al0YdcpYQQC/Oyqb2+UV5or6MJ0CqBm2secyWE09Hk/uvYazs96Gsb0GgCR2TzTaP3t3sfFHTHh
 yF3XNaCdTpwQ==
X-Google-Smtp-Source: AGHT+IHO2V1bsaTMTAIzevoARrUfFyOd79E9ptlBERqbRbCdB46AjpbkeBFIMBwtQnU1lNqAxCE1Og==
X-Received: by 2002:a05:600c:4712:b0:456:fd4:5322 with SMTP id
 5b1f17b1804b1-459f4f524c2mr29174145e9.11.1754667129515; 
 Fri, 08 Aug 2025 08:32:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e78a35cdsm61373235e9.3.2025.08.08.08.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 08:32:09 -0700 (PDT)
Date: Fri, 8 Aug 2025 08:32:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary
 process by validating dev_private pointer
Message-ID: <20250808083204.0174ac6b@hermes.local>
In-Reply-To: <PH7PR12MB8596FA05DD99084208A31E50822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250729143420.0fd7b627@hermes.local>
 <20250730050702.74381-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596FA05DD99084208A31E50822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
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

On Fri, 8 Aug 2025 03:49:01 +0000
"Varghese, Vipin" <Vipin.Varghese@amd.com> wrote:

> [Public]
> 
> Since somehow the email are split it is difficult to see the indexing
> 
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > Hi Stephen,
> >
> > Many thanks for diving deeper into the issue and sharing the insights.
> >
> > I agree. given that the primary tears down all the devices on exit, the secondary is
> > left with dangling pointers and inconsistent state.  
> 
> Secondary if PMD should not be attempting to cleanup (especially for ethdev_ptr shared from primary) I agree to that.
> But should not be covered in library or PMD. While cleanup for other needs to be done properly
> 
>  Without a mechanism to notify or synchronize that teardown,
> 
> You already have health check added in the code for identify if primay is still alive or not..
> There used to be MP thread spawned which actually piggy back the communication. Is this broken? Can you please point to git

There is no easy way to handle the case where primary crashes; leaving secondary process with
pointers to dead data.
