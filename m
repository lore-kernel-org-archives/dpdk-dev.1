Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3F2C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:58:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2400D402A5;
	Tue,  1 Jul 2025 15:58:02 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5EFA340264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:58:00 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-235d6de331fso40569735ad.3
 for <dev@dpdk.org>; Tue, 01 Jul 2025 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751378279;
 x=1751983079; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBd6sq1fw5GOvV+6hi3e8HokcswvD11D0mMQSiIT82A=;
 b=NG71NuSofrvwI6mfJVlt0IiLcXnsXYIEhgp4PtTwjbV1bDrnRZlV29/ZA+5m2Rf0co
 rktag0fKSPkU6xccj4W5lf+ACdHo1r6OeKCATLQ4hIJ28hqr1R5Blc5KiKvZCI5M7W0c
 o40AuYdt+oUA2N9vq+49aOq6pL611zGdzuefdN1B4fkuzURsOmGc8QZSwIUwqditR8Sl
 sAUk/rN+fGPbRYuKXBl6ZWqqSNvy6OqU9NCF7xcAT9iqIBpA5sCkSGFQLY8+Su5+me35
 5C/emX0LY55q5teahvJhj43ubdPaMIjlkmVLxlLdcdk5wMGfew/5rbfDmrQPjRMH9h8V
 VDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751378279; x=1751983079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBd6sq1fw5GOvV+6hi3e8HokcswvD11D0mMQSiIT82A=;
 b=GQnAkK/j8Q+XffAR5wVPXR0ZFpkqR9xbGom9dpFE83f4gaGL6iqxHvBOq3mY+VKDCQ
 cToprhu5mNUJTklwJfkOC8jCN+y/MFUuFjxkbGUxe8GOSi3V2cmDHSW0dLo1FG8M1r0W
 5025GrGJjyK3EiSaD7OckXc8gLYhL/tjsfwQXNZkoa0CV8zKJtU9BdCq6h0/3pMdXGL7
 P5kE8+8R64PqnHXkJfrm4FRBsASPXfqUJBZ0xMCCWg/cM9xWJ7T9nA5onKBHnR/vLFhJ
 SOqC+FhUqEUnc/hu/IL2nknW1YTj8Z/JikQM2T1UxkWSyJueMstvCNpIt1bB5v4JeFQR
 Wifg==
X-Gm-Message-State: AOJu0YzGqw4704FXjVOPcaALL24mqafUoxaGQv9lz95H6dK22Hy1u4as
 Qw6HC5L6uYBlBjbBB1TcXCaIaStehF0AKm3S6XuKl/ssD0PSZ/mppPnEd20LEIRplsk=
X-Gm-Gg: ASbGncuO0khYhVCAIQYx1R9u6uLDLiStFlNwQ4m1GFsiSa+h2G+jkCcyQPbrqpcx+PX
 H6xgdU9el/OzKsBywr2/koXIcGmMs3ZpgGdgsbZKAaV4HMG5b1Th2bCkhm3QTGn/qkmMLcXMSYB
 hblgxHfwt2FtGU3zQT2RaOjAS4q8jB16OOP6eqwXREcHWXMdelliwBA0mZfS6mxjuXxyIN0JFyq
 kZxhJgrPG4Sc3Sy3zqT/lF+Ae+7Sn3p7YcnEl8SeDxy0GjireHnQSaHPV8WxmJIc+OXIiTYrVyn
 eY6NrrtnImysTlq0IkcrCohQEI9UWj94TItd0wqgx/WQXF5/aEGhwbPqJbwky+GiqHgTPqkc2nO
 JuSTlA9vVP2XtwiHRsGAZQ1VGs8X17yk+R/Fb3RJVRbgpSAmnMA==
X-Google-Smtp-Source: AGHT+IH3wsO3ksYH9sAk82oenuPjR4vjTv9JkrOnW+uECafmFvtoEITqYKqw/gRGzMZ9UYsiqv81kw==
X-Received: by 2002:a17:902:e54a:b0:235:e942:cb9c with SMTP id
 d9443c01a7336-23ac381b1aamr318622865ad.5.1751378279427; 
 Tue, 01 Jul 2025 06:57:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2f247csm110634135ad.79.2025.07.01.06.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:57:59 -0700 (PDT)
Date: Tue, 1 Jul 2025 06:57:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, Vinod
 Pullabhatla <vinod.pullabhatla@nxp.com>
Subject: Re: [v5 6/9] net/dpaa: add Tx rate limiting DPAA PMD API
Message-ID: <20250701065757.1b41fe30@hermes.local>
In-Reply-To: <20250701113707.2793004-7-vanshika.shukla@nxp.com>
References: <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-7-vanshika.shukla@nxp.com>
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

On Tue,  1 Jul 2025 17:07:04 +0530
vanshika.shukla@nxp.com wrote:

> +/**
> + * Set TX rate limit
> + *
> + * @param port_id
> + *    The port identifier of the Ethernet device.
> + * @param burst
> + *    Max burst size(KBytes) of the Ethernet device.
> + *    0 - Disable TX rate limit.
> + * @param rate
> + *    Max rate(Kb/sec) of the Ethernet device.
> + *    0 - Disable TX rate limit.
> + * @return
> + *    0 - if successful.
> + *    <0 - if failed, with proper error code.
> + */
> +int
> +rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
> +				 uint32_t rate);
> +

Too late in 25.07 cycle to accept new features.
Please resubmit for 25.11 and either figure out how to do this using existing
ethdev API, or mark new function experimental and add test-pmd case for it.
