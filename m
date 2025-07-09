Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB80C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:38:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0997140B8C;
	Wed,  9 Jul 2025 19:38:34 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id AE9FB402DF
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:38:32 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4a9b08740e3so1508951cf.3
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082712;
 x=1752687512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiQhmFQByqfgl4nGYmJRVzZUHcDbdokvLrxMpFbrns4=;
 b=w20ZN0bThJHQ+b8UFW0dLiPrT4MOYrX3t2NochIMAtY78xTYFpqicHyXMCIBEH46Tn
 /awd1vVcf0Uo4xaBnCAGYIvs9Eumim1GWQcI8OGaXSoTpS0WjmJRpbPF3IE5dWxtbJJY
 c3cdr3B/akyKMTJ/VQY3zXKW0/RbJtNusqaGYw8TT2GDm69rRlLqToxSb+LTdam5yOkl
 ct5WKVXHbKmY2itSK4QbyazHcsg0aWSKbFxyG/vJ4WngOLs35w72A3UwaD28/OaZ1A0G
 6XSa4eq/UZ4eRr5Bd/+hVtHlJu+y73kw0LFz/EvvheANQ3cTw4ijAukEGS6Gio6gaj/H
 aQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082712; x=1752687512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiQhmFQByqfgl4nGYmJRVzZUHcDbdokvLrxMpFbrns4=;
 b=BFIPRoRY/O9NYYetD4lHiNzfcE0XnGv3U4M9xSCbDLKCwsyqPY/LSm5llZX+4gIJLn
 hUmjBRAqe5LMvguE4fsO5MSyuUAQKylhnBWah7dOQXp514dliVPEeVNPUAzFY80EUrIF
 /YdBn6aW36Y9xyEhU0IZ6oasvxEs2Bq2clkaCGbsMPUJL8Q+p/W8JmYr1dRfF+tBT3i3
 WeUZwcXSMA6yTPriUCklOm+05RUozOoSr0v6PYGuIWJiSHQ4FqO7nScHI6Q3qt3nC48B
 /Hin3gtf305HxMJAX4E6OuTjGia9IwtoxwzfzYSRWqkCMK4E+VWluMpidYCQAZhBJ3LQ
 fSuw==
X-Gm-Message-State: AOJu0Yx81BnwQIIOfGDN75qTXbSPhVmU8iygLPBxA0DFfKxzIA2A7XA2
 lF+GCCVX5n1nOMGy70jVqtlMRmWPuKM2Rfd/J8LK8q9rIYLfU6CNga34VrgA0GPxNfAM/tazK6X
 4amIM
X-Gm-Gg: ASbGncsxEhDCZQmKpXBjpwc6Pdn41Jx5zb+CMwrTeSQoqywwRge+xWNwWXk7BLSqeSr
 yDDp90dIoHIvhsom2FLs+F5QFQvxzM1wP+vNLQnPJVm3mSloFSy9XsRlwntVKuk8C+uUqVN8F1+
 qbkFPT7DE3LfTdC97jPEf3nlzsplppz7hvPznAzziT8dn50waW45ITcxajNkvWbyprkd1qfLHY4
 BSMIznvGxHmcgVEkR3Kkzjz1kfEesAlK4LWXQ2cEp2p0sZO4/ZhRtUi63Aj3qKlXl5qkn1fpoOF
 j0AQRhyYjuZUztaCRRQBdAOtDZh9M+UU5cpVToGfuda/aakzYHzaG2cLSW6vhokvMc9oR82rLBu
 dJ9ctPKAxwOEEEPjsgBqMJNOQfsCnlPsTj2WiLHHbMsCBR54mhQ==
X-Google-Smtp-Source: AGHT+IH5NYLhrsFZPK+IseFzofT4Roa+p1LHA3LO2jDPWZSIQ/WTPe7LxrOGyk/qh+WdWGzLaUTw/Q==
X-Received: by 2002:a05:622a:143:b0:4a6:f416:48b6 with SMTP id
 d75a77b69052e-4a9decf3a7bmr49633851cf.28.1752082711990; 
 Wed, 09 Jul 2025 10:38:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a931desm101220331cf.68.2025.07.09.10.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:38:31 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:38:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, Aman Singh
 <aman.deep.singh@intel.com>
Subject: Re: [PATCH v8 1/1] app/testpmd: canonicalize short PCI name format
Message-ID: <20250709103828.456d44f3@hermes.local>
In-Reply-To: <20250708083740.128610-2-shperetz@nvidia.com>
References: <20250212163836.178976-2-shperetz@nvidia.com>
 <20250708083740.128610-1-shperetz@nvidia.com>
 <20250708083740.128610-2-shperetz@nvidia.com>
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

On Tue, 8 Jul 2025 11:37:40 +0300
Shani Peretz <shperetz@nvidia.com> wrote:

> when providing short format PCI device names in devargs
> (e.g. "08:00:0") it is converted and stored as long format.
> however when attach_port is called from testpmd, the user might
> provide a short format, which will be passed to find_device with
> a comparison function that simply compare stings, which will
> cause find_device not to find any device.
> 
> This fix canonicalize the user provided string before it is being
> passed to find_device.
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Looks good, but builds are failing and there is a typo s/stings/strings/

Please resubmit
