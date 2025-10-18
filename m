Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5464FCCD193
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Oct 2025 16:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89CE540EE1;
	Sat, 18 Oct 2025 18:18:58 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 4DFE04013F
 for <dev@dpdk.org>; Sat, 18 Oct 2025 18:18:57 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7a1603a098eso1917540b3a.1
 for <dev@dpdk.org>; Sat, 18 Oct 2025 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760804336;
 x=1761409136; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/+1dgezovESCh6+/10gQtaF/nvURh9tvrz6RBP31Zg=;
 b=m0vQ2dRJGv9dZ0QmQbnVtFtJWFsh+RJLCzASquO1vCYc9CMrtprCPWxaRiqX9AO1h9
 TgWGATNfo+AXpXo9w+ipYBBmswuCD9/ySJ8Wvu2ADPInpPnybsX+ZML+dToECsXN7VhC
 1Q56NW9eTkotQ6ODfFcjEajQFn0ecWIJzWqY5eMmjRdbkjJHV+KZJixFFRJlG8HQqyfx
 ehCKrA56Bwlm6eMGRF/XfMAsmlLHE4uwJbUpCEf+3buU+T9HOoijkQs874OJBigu/9PG
 XLZSt/UNYv+8c7PvpSvE4pqFj1NfS7inSiZwDohul3R6NPEybAdjJMUO8KvjQZcYNX1C
 0+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760804336; x=1761409136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/+1dgezovESCh6+/10gQtaF/nvURh9tvrz6RBP31Zg=;
 b=fiXA1nS8OMvieAssh2BQvKx00v0CE94cNM2DcBrFPyrYY+CVJDbuIF/vmzSW3maJfT
 vzpYt9XS2VDDCmKIv6mjBKzqGd1IQYqzIcASVP3rdq/gv3y656CZ2xw0hHlgW0R+P3GH
 KmYgwTjM63SdPZiOvbDUfIHlNnyA/GQJYUK4ki9twdVCm1SHfUzcwpozH//A7UthOA3m
 5v0SrdsmyQG/fPIN5rgxRTB7tRoVbJW3Jw6sU4gCELR18vxc9zCR+WDuU32kxVJ1NE6i
 RzQdy6DmzdQUsqZBqtDqjW83E1mA/c0XpgBidZzjMksb4Dx+QXHCevLcEUzeBukwLodH
 W3Sw==
X-Gm-Message-State: AOJu0YzRXp6lYUAQnKxVWrrp1FSHDOeYCUrQPGdSmQA700dGGDvJ2qDZ
 oxJuDmfmWD5p/xPnKq21xeZOG4CrHgRkbO/x4MOQe9U+2uniD7/eFWJKNtV0Ko84+B4=
X-Gm-Gg: ASbGncsuZlO8ofMLxqOHZhc/Gx/LIqv/w3eg5BY+EaB40b+HUJgFzHwt67mgvE9a34y
 rK+bDxoHSqfeACyg9fzYmBlG9o/CgITBWsnwqunDjir4qoM1B1WVyYYlZU91s2dikYj5WY+fXRC
 Zf/CmW6FZ9f9TLPu2D+nPDzZCaJF6Y3Zclx92SpeqvvyPhiTPp2FAukuveKEve0ay6d3YkdLfYP
 DR8pt5YHA2oGT1f5nIGaFgW15HJY2vCxEZ71f8k9IONHhJPA32MOHZlpz1Uf/9Z7OihryQFarjy
 PsDTJR4+dHvim028ihyOlXe0r7ZbSJpLjoQIVKuGF6kU8Xksc0Xsbp9OYFEb5ldRf/kvpI747SY
 Qc7rgIWlQInrM28fr3vKCo4g19Xg+tVBR63tav6sct3L2MRJuVpcVhYnnew6Zj5hy+MC3ywjron
 buqQfFk84fkEcyW3sJI7bEneXIBguHiHEysWH6nwspKNwKFqv1jxwFaqBy//ae
X-Google-Smtp-Source: AGHT+IEba2kmeGFazuHYC7dzeQApEof5BkgDknhwlk0kATkkihduGG8wXIwbKnDzEOgaxTh19dQF1A==
X-Received: by 2002:a05:6a20:549d:b0:334:a56a:a55a with SMTP id
 adf61e73a8af0-334a8629f77mr10432281637.45.1760804336423; 
 Sat, 18 Oct 2025 09:18:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a7664a462sm3251685a12.8.2025.10.18.09.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Oct 2025 09:18:56 -0700 (PDT)
Date: Sat, 18 Oct 2025 09:18:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alexander Kozyrev <akozyrev@nvidia.com>
Cc: <dev@dpdk.org>, <bingz@nvidia.com>, <dsosnowski@nvidia.com>,
 <orika@nvidia.com>, <thomas@monjalon.net>, <matan@nvidia.com>,
 <ferruh.yigit@amd.com>
Subject: Re: [PATCH v2] app/testpmd: use table ID for jump to matcher action
Message-ID: <20251018091853.2c09d35e@phoenix.lan>
In-Reply-To: <20250926123045.3944957-1-akozyrev@nvidia.com>
References: <20250819144508.722653-1-akozyrev@nvidia.com>
 <20250926123045.3944957-1-akozyrev@nvidia.com>
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

On Fri, 26 Sep 2025 15:30:33 +0300
Alexander Kozyrev <akozyrev@nvidia.com> wrote:

> Current implementation requires specifying the pointer to the table
> you want to jump to in the jump to matcher action. It is inconvenient
> since there is no table pointer shown anywhere in the table management.
> Table creation/destruction uses the standard table ID for that purpose.
> Use the table ID in the jump to matcher action as well.
> 
> Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>
> ---

Queued to next-net
