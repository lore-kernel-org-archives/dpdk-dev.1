Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B1FC36002
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Apr 2025 16:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E426F40270;
	Sun,  6 Apr 2025 18:09:44 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 4522B4026A
 for <dev@dpdk.org>; Sun,  6 Apr 2025 18:09:42 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-af55b7d56a1so2430630a12.2
 for <dev@dpdk.org>; Sun, 06 Apr 2025 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743955781;
 x=1744560581; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bEbr8evGMM1goiCjPVue5P2UgseMgFHTSuQtrVq8/M=;
 b=a61YaP2mW7h/4JduAoLNwiWwrUmXVRC/rczK2axz6gbgX9MB2PznLN/sEAJFbQ4tJG
 VrVTPzT4wkLcgQ2jkL4if3GAepImFF/mCzgyWHz4o7BYkj+sgxIjhQOAruzfsS4UuXkD
 MzNrHPMfAq0sWhAlOfmCzMo9hSsuoqfVZpEJsFYBYs0zcOxZoPz8jHlPOi+JwmRvzLtf
 ifosIH8K/oGJ07wQIRp+CvBmRrDHGnh06GmdSwSJdg/jJ6w99s6/qCv76Wn4uwtOagdt
 Bj3lkfGEYZgufl20CeR4GE1oHD/2tlKumrOGC8vbhdxNWzQaK8jZLWBLRWjwYMAZEltS
 vHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743955781; x=1744560581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7bEbr8evGMM1goiCjPVue5P2UgseMgFHTSuQtrVq8/M=;
 b=qNH7O24UAO7OO5uJDa2PT9f6851iHMBPGkSLP2+gY3SoETrLlMjEcPy9DJ/qPW2oQO
 TlZ5LDshtSjY+oDYjay0dBQqzoZNh7xQhPBMmf5/RsFJ40VsCdPyBBhVvteFjWQsPbbd
 pVLUjl1cr1dw6ngH/QulxaY0q5ePIJhP8H+mia+QoNa8iRXJTxVnyiDobVwKgKPoHFel
 LGNhzTaPX+WY0Ilr8VW8A7B+UcbppXSGU6qm3K8DFzdsJFg2wrkAn/KvtTTNnLECdjvh
 QM1oUJpx5/9l89vuvF0NEd09E/5HQlEQppUIsDbCgs5lKQex3u09Flp1h3UnvrCkZ5hB
 To3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQZXhirs2Hs8X20d9rEcgJqgm/wbsZUC+8+CXuakopVGmTHeiHYXD6Z5ru85dzJ2ElxvA=@dpdk.org
X-Gm-Message-State: AOJu0Yzax6ENPEN9BzdlyeAqhw6oc0ya/0DWNw5nNGYSoPtJZMEr1CtO
 fvmN+67ko4rwpzjOZ7NNgK176eUWw9fWMwVfPXegScnwKP96D/hz8g6hHNyQUOU=
X-Gm-Gg: ASbGncu7Qm0P5d4V8KqUkr0ofYNWXCMupZksPsaV/q5ESapGXkXV14uPdG7jMwO6YZz
 uHgdLq9TFXFj18caZkuQyY8ohpz3e3ms5Egb8NO55mM3GqUNEctVYXf9cGR2jyIP8nTtTeLZe7y
 cHWnhylW1p3y1ptMd/48h5JPVAcOENzddYT2KJodwtKHFpzD5p24ykOEmjPZRsEL5AIrOSfbfaI
 zdMgjZnMdnWh/bnUuo83Iua6AJrNaBd1g0xodYNkImfDO4z2zC9xVv820oP/G5sqRIbApO4DbR/
 aqlCqxU/tu3k/gnUhqc5jaL+lfBEJcyRimV0NHPwoQyzAorK16myGvJvOG2xT/UIRdQfKDzCAoU
 exRufLYrWi9mUK2l5GJm/O4HWlMFoJzc=
X-Google-Smtp-Source: AGHT+IFDtQxwbYXbnTdsty9V72ibRHX4UE27m8clf9K+dUgf8czjfmXn6JTSbsjHYO90GoWvsABY6A==
X-Received: by 2002:a17:90b:4d06:b0:305:2d68:8d91 with SMTP id
 98e67ed59e1d1-306a4b70ab9mr13732895a91.28.1743955781506; 
 Sun, 06 Apr 2025 09:09:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aff7d3c2a11sm95028a12.26.2025.04.06.09.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 09:09:41 -0700 (PDT)
Date: Sun, 6 Apr 2025 09:09:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, root
 <root@longli-arm1-vm1.lxficwa3xisuzeoisceafmmd3f.cdmx.internal.cloudapp.net>
Subject: Re: [Patch v3 0/6] Support VMBUS channels without monitoring enabled
Message-ID: <20250406090939.12fd9bd1@hermes.local>
In-Reply-To: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
References: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
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

On Fri,  4 Apr 2025 17:35:32 -0700
longli@linuxonhyperv.com wrote:

> From: root <root@longli-arm1-vm1.lxficwa3xisuzeoisceafmmd3f.cdmx.internal.cloudapp.net>
> 
> Hyperv may expose VMBUS channels without monitoring enabled. In this case,
> it programs almost all the data traffic to VF.
> 
> This patchset enabled vmbus/netvsc to use channels without monitoring
> enabled.
> 
> This needs to change the APIs exposed by drivers/bus/vmbus. Becuase those
> APIs are used only by NetVSC PMD and not feasible for use by a DPDK
> application, all VMBUS APIs are set to deprecate in upcoming 25.11 release.
> 
> The notice for deprecation is accepted in the following patch:
> https://patchwork.dpdk.org/project/dpdk/patch/1742242184-19600-1-git-send-email-longli@linuxonhyperv.com/


Marking these patches as deferred until 25.11. Send new version if you
want before then.
