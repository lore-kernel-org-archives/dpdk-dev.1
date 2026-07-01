Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB4C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 20:46:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51E5840279;
	Wed,  1 Jul 2026 22:46:29 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6444F40264
 for <dev@dpdk.org>; Wed,  1 Jul 2026 22:46:27 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c8b49639fbaso620787a12.0
 for <dev@dpdk.org>; Wed, 01 Jul 2026 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782938786;
 x=1783543586; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CDc7da9PZXSa4cJdm/WetEmxBdWxNnU/fDXoNpb078=;
 b=LpDePfVPUjf6hq/RcLisDCqWihWV0xZtAVFGfzIluJbF0ou3Ig2kO9D0onuzJ779JX
 mHbkV8kfnAmTo5CMubNhpymZ2Iw8YrggTezh4IEgoPPL/XUGwdcdNU1CTqMVd6hbrM2X
 27RupeNgJK0TBbHJNWv1QDq3+W7+gg8pg1WWRyPM868tgqMXqF3XqFxtmQGoxhlKZUGz
 DPsMeGYxY9tOLmFBwCVRe2Ny4oQSNqsGCiE606eErzivUToHAw7BT4nE2ctmnqQXaQx3
 1L15JGaUGg7t1rwoMoF5kpiXW7B0eIVs88UiPe49rvdtoGogFkEHsZNg91MwNsIUNjOR
 fSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782938786; x=1783543586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3CDc7da9PZXSa4cJdm/WetEmxBdWxNnU/fDXoNpb078=;
 b=Jkp7tKFu3yehrYck59VJy9U6eO6vYgcwb2VDZODGUquPKMVKGxAzXKKkL0bN7Ki6pi
 JECOuJmme5BAFt9gc1PSPx9WJjWvJy01TbIQROMSu1w/VaJL5fT4Amk4Zljksu35CeHL
 EdEu4vz8LDlzubLBBOoLow8ITCaOJgQZeJsaJ71ptrV3MsaFeOmYgx45N7okhZ1fA8fS
 dykoYEzEw3Vtz89vU/0eityQ8dYTWaEiHnGUji8VZWa0X6TTCn1xLP9KpXt2CB3I9eBf
 PIVEmbNH7ha/QkmCUQtxFREsPvBdjLaaUjIAqmD+ZuyeMm9+ogsu2kLzt2iPlQQcwrv8
 XQ6g==
X-Gm-Message-State: AOJu0YzsCtX2Upm5smMwdmGXn9dP1/XREq+U1rJuKBbe6U5E5wktpyJL
 UruRN8EOQGa6iQ/8WNhh3zOKUYoevjz3PLe03A//RM5A9CvsTkF689C4ET80TH/f5iw/Go2akxV
 p0rWP
X-Gm-Gg: AfdE7cnJ7DKRYY4lFqlFElnxfRxHnz5+UAkwlCG1j/Vtul9JZ4DQnhaNit5uS6xDQfu
 frzk3RiODkuhulJ1bhS74tWH1DUZnpZAIfcqtF8VAxkmLu9Ine9y4yt+9xlfeM6xaK7jg8A6f7l
 xQ4bJ+x6G5O5zUDyqA5s1DPTJJNbwPYB+yacgQ+Ix/GqWaENa3ZmM6ahxFtilsYYNXzMRPJ5/kD
 95VaCQriBtZbkJSYI+/F0HNW8otjRNqqZ53Q04FkZoC4j1aakgXJL+rd57AMbY8vvfm9lKm+EVN
 i8TWNrpbCy6aHs/RnK0BkRwxmaiTSP1+946rz9J48ts72Ms1mCqNc4dr5WtkjRx6hn2fM5pdapx
 s3Nv7/4M/Yk6DGPSS6Zs9T73FA5GMpccJrtMBWbjx09jVHSysrlETWN8FrvJHL/rQTQsUsrrl7g
 oEDq1UO6A0admKsUHShYR8TjntMAJdWxdlnQ1k2X3Ak9YyZNuhLV27xA==
X-Received: by 2002:a05:6a21:6803:b0:3b3:f46:1ef3 with SMTP id
 adf61e73a8af0-3bfed5018d9mr3808334637.41.1782938786243; 
 Wed, 01 Jul 2026 13:46:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85bde6sm1755949c88.9.2026.07.01.13.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 13:46:25 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:46:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "WanRenyong" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH] devtool: fix falsely reporting from checkpatch
Message-ID: <20260701134623.54491400@phoenix.local>
In-Reply-To: <20250120112654.1049456-1-wanry@yunsilicon.com>
References: <20250120112654.1049456-1-wanry@yunsilicon.com>
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

On Mon, 20 Jan 2025 19:26:54 +0800
"WanRenyong" <wanry@yunsilicon.com> wrote:

> diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> index 003bb49e04..2e228b7f92 100755
> --- a/devtools/checkpatches.sh
> +++ b/devtools/checkpatches.sh
> @@ -384,8 +384,8 @@ check_packed_attributes() { # <patch>
>  		res=1
>  	fi
>  
> -	begin_count=$(grep '__rte_packed_begin' "$1" | wc -l)
> -	end_count=$(grep '__rte_packed_end' "$1" | wc -l)
> +	begin_count=$(grep -E '^\+.*__rte_packed_begin' "$1" | wc -l)
> +	end_count=$(grep -E '^\+.*__rte_packed_end' "$1" | wc -l)

Using wc to count lines is unnecessary, grep already has a count option '-c'
