Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135B0109C046
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:51:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 246E5410E3;
	Wed, 25 Mar 2026 17:51:03 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id B1A524028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 17:51:01 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2b0586d5bb8so148005ad.3
 for <dev@dpdk.org>; Wed, 25 Mar 2026 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774457461;
 x=1775062261; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLgg8gXVcgjogPp+SD9Al8DWVghB6P6js6HfJTOxTiA=;
 b=q7kb+WfPFFy4kELf1RXqsf2ymVOGmQcIeAEPBlmUlK8GU2hFW2q7JU+f1Nd4/xwKOA
 UDaYeBIOAOklwBsS2711l6zG3jEZcoGVEv2mtP49Boo/LgATkUHgndUvJudGzqRPNXA+
 c0zumk3EIAy6n9nnITSzYFb8bxh3/MlWuTIzYWrmdCE3LxjGPrnsWg2eD2WV0ZPIH0sp
 dBqLy8HPzp3xaF+bT4IGnwCEIjog0VZ8X60eKR1dTM+nL5C5lHLETSzhqgWs9c8sYKbl
 cLtl8AHciaqhgqGGP03DE+0rpIOyw5HgYATDPpe4lgQv5dLJBuE3v65WrDl0TAqNm2fA
 4B9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457461; x=1775062261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oLgg8gXVcgjogPp+SD9Al8DWVghB6P6js6HfJTOxTiA=;
 b=rgPUPpa+EiCvLKgUYeuokAGmXiMdLkgRBHzgo01FQoCfyqgrl3vSqv5npU2lnKJh7s
 ceKTA6Q1Cal1ygpPJ+W1ULpvaEK81DC1mJBarcg9RV6zKpqSOFz7SBlwM3ax/nnu4rNN
 GbHD5kgBVB0iT5KFJGLEpLuVCIeVdzXBrAMOorP98Tw1+x8GJ2zZRUc6j2G4AdgWsNqZ
 pUbIOqpFMrf+DhgyxfaQs4jQjxxKHujn+KPpxeRZwk0oUOPtqgmIzc3wRQ1HWUh2T5HG
 zLPDFj2yDpa+O7Z7KXQOW1igzbxvNdO6eISzn5Irbd9Iq0BqIBPdXHZy3S4+/iM1HD7d
 enWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMydssvfPpapOmckR7Lhe8y+3Vj4ekkp7GiKbXAyiIsHUO2/2sIbJ/BynHz3wb1ts/Urk=@dpdk.org
X-Gm-Message-State: AOJu0YxzTyUJk6TtAZuVU1bS3aCYkRCyOlaRem76HUByMkiuusceiX2A
 rm4Pe1EtvP9hfs78y8/QDOI1IP+21PpmAkScHQfdRY/F5F3vE0o4kPvdJVU1twuch68=
X-Gm-Gg: ATEYQzz/9QJOAsfrV8f4G3r0nMYrUvSs2N4JjaevTl2YnAu9/2dE5f1Hrrq3hjJ75Ry
 1EYBOF8PdDp678XcnqJ1xfxwOg9tyJo6VfrIxqDl5bVNDNSncqkkOEdk0iO7TXzzncstzs/LbKT
 qL4UBMB3JZ24PIiZmQpONSuFEpgPYJDl7gEOIoIqGXvBQ3R5ePtwJ/yfvvCEd8emIBX+fvq2j96
 hpSx8n/kw+CoWiEszCblKpr9GBnFPBA+F5AxMk5fDHSYxsC5cF2NTQ692fzdYmRlIEBmj/clDai
 aZXWv5tJ5IOzvLSMCRQhL2mZ1g2YxaHiPzutySwlczA8Tn53NWtgnATkATBWhJJUYEq0qYjMLK9
 NFZulxA3f6XKGoE1geU5i+w4IXdFV15s9AQeuaKxRD8phaQgqPhT0/OSVek2zfvLni7y9Gs53Tb
 0vVvbEE3d2K7aHe66qQo1L/R7rPTmlh+NNsNs=
X-Received: by 2002:a17:903:2b0e:b0:2b0:ac21:9e35 with SMTP id
 d9443c01a7336-2b0b0ba29femr40348825ad.53.1774457460839; 
 Wed, 25 Mar 2026 09:51:00 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc87ebf1sm3493955ad.44.2026.03.25.09.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:51:00 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:50:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: Re: [PATCH v2 1/2] app/testpmd: assign share group dynamically
Message-ID: <20260325095038.76ae5740@phoenix.local>
In-Reply-To: <20260324165657.23945-2-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
 <20260324165657.23945-1-dsosnowski@nvidia.com>
 <20260324165657.23945-2-dsosnowski@nvidia.com>
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

On Tue, 24 Mar 2026 17:56:56 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> +	/*
> +	 * testpmd assigns all queues on a given port to single share group.
> +	 * There are RTE_MAX_ETHPORTS share group slots,
> +	 * so at least one should always be available.
> +	 */
> +	RTE_ASSERT(first_free < RTE_DIM(share_group_slots));
> +

Since RTE_ASSERT is compiled away in normal builds, this is a noop.
Please use a regular if statement and error handling.
