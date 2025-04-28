Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269CFC369DC
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 15:55:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A72D402A9;
	Mon, 28 Apr 2025 17:55:13 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 162CC4021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 17:55:12 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso4786437b3a.1
 for <dev@dpdk.org>; Mon, 28 Apr 2025 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745855711;
 x=1746460511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVol266WxtHv5IEre51uSlmvozbNtay3T497RhHz0F0=;
 b=w8B32Z26r0lq5dYYP7e5vC6UBaJZqkj7IGgDEdBPD+fAVmH8HdhFAFJv8TjF0fR7j+
 Y0LyeMpcsP4pA5z3jlfB43vt+Wn8RzVo6107Pe/EU/qzNETu1KjO+domRiHGJ1f4cH7P
 lo7YvpCAWEpcHsW6qdYYmhNDHOd0zRCszO7FmqTKJbiksF9yiOkfJElT7HeJCIssrfmM
 EnsUVCzSRkgzJn9FmURirox7xuLCU80v6H0chBgVkdPNwSy6r/jklUeXN/LC0Azv5Pp5
 jvrPbueRw3x8rsVD8KnoKMC28CJpgCiqsjEYmCIH5qSnPJxZTc4bODXrEhKZz5YIJMoB
 qyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745855711; x=1746460511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVol266WxtHv5IEre51uSlmvozbNtay3T497RhHz0F0=;
 b=v0ENZL4wJY38/L2LqdZrbDZdMg3eYLwJcNkM/5rkeUC6coMW1h16WKcVNd66WY7/8I
 RXW8ZxCifBirgnS5zCvX8XGVCHkJ1WOvAIeuNKSNjc8om7aHds9NO6oto9bWfezlhsid
 AVKShWfB6z9KCB182INILHTqYglMJ/JuXAtbJxiK3uU4OIpON3cyGqI4Cpzi8nIemg0I
 2oxx6Ffzk++0pAP7w/N9FrTWMZwteFhSUN0QkpmTLtTfSuIiyh7KwR3x0ZHX18Tx2PVy
 z3QAVQYA6E5Q7c8kX5baq4zEl+3MP5GUWw0BWy111oLAtqvVA6AhiSTU8FEOLBuj0z4b
 CNvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQlmslMk+5lrhSmdthyCk4h9V4//qeiAfLSgFNOzE9pjv6q4nsshgISoCftEOlzPYrAa0=@dpdk.org
X-Gm-Message-State: AOJu0Yw3WrIwXnON4cZexcCvJzFd+GkLsjltXFFdWvtkxysQ9oEta829
 unpNpNLNG/0i+ZbmqiGnCPhUSGjpNExHAWSEPVpUunS3qmjd2yTJiQXT7IDTpr8=
X-Gm-Gg: ASbGncuESFx4ybmog/DdK+8VYNKsjopB/mEdWab9MZdFzwLhc2ljOWtiafUOTY9/g9c
 1DshRxes0sQm7COU1JpeVbw0PW2i1MbG1kXo5MWNUj/xY3iY6MdTmA8GNTNrZeHGk2OS5ahtfXS
 4ovy+z5zVySlE1e6ebRoYm5gkRpkcxyjnipO/r5UdUyPyLqZXloMpb1RefBrf1HS8W8+MafrC8c
 VFfhs8s8fz24Romtg37Enu9TWXGeuuXS5OEV++RC2TkxctAt+ePziNJcHgLSCi072SqZ02OWWKC
 tT4j2+IpXS1/zw4xP0XsEz341SnQRK4NKEaHtDlje0YGO5uK1pHp2Ei34WalcwhvSU7pCtIDKXZ
 CiMaNqki1SDLre3ts
X-Google-Smtp-Source: AGHT+IGVfxnpR3sNbkyw0SRc7VcO9gHPEPY+H3SaBHJPYWpYtLxB8Uyqh1yw911FvNBJ/xUoZf3VRw==
X-Received: by 2002:a05:6a20:d04e:b0:1f5:52fe:dcf8 with SMTP id
 adf61e73a8af0-2045b99e15emr18680503637.26.1745855711205; 
 Mon, 28 Apr 2025 08:55:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25967aedsm8110150b3a.83.2025.04.28.08.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 08:55:10 -0700 (PDT)
Date: Mon, 28 Apr 2025 08:55:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kyo Liu <kyo.liu@nebula-matrix.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, dev@dpdk.org
Subject: Re: [PATCH v3 1/1] bus/pci: introduce get_iova_mode for pci dev
Message-ID: <20250428085509.44197fba@hermes.local>
In-Reply-To: <20250427022734.151043-1-kyo.liu@nebula-matrix.com>
References: <20250427013611.150888-1-kyo.liu>
 <20250427022734.151043-1-kyo.liu@nebula-matrix.com>
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

On Sun, 27 Apr 2025 02:27:34 +0000
Kyo Liu <kyo.liu@nebula-matrix.com> wrote:

> I propose this patch for DPDK to enable coexistence between
> DPDK and kernel drivers for regular NICs.This solution requires
> adding a new pci_ops in rte_pci_driver, through which DPDK will
> retrieve the required IOVA mode from the vendor driver.
> This mechanism is necessary to handle different IOMMU
> configurations and operating modes. Below is a detailed
> analysis of various scenarios:

The words "vendor driver" have me worried.
Is this a PMD that is being incorporated into DPDK or some out
of tree driver. If it is out of tree, such changes will be summarily rejected.
We don't accept changes that are unused in tree.
