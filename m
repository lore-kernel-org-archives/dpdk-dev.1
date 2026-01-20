Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52986D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 14:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3349240E3A;
	Tue, 20 Jan 2026 15:35:07 +0100 (CET)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65]) by mails.dpdk.org (Postfix) with ESMTP id 2260E40E32
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:35:06 +0100 (CET)
Received: by mail-wr1-f65.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so3278812f8f.2
 for <dev@dpdk.org>; Tue, 20 Jan 2026 06:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768919706;
 x=1769524506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXCnGV/8gnvvni4iSXIKKwOs9GPs/4AmCoeg5x0FRrU=;
 b=ui2EHQBYZIgIX5D98mikonS5rCuzPQ/FcphX1vJlkloYE4EAc/7es8g1DV5Wbs4OBY
 6zvdHnVisaHVkbl2qn5P9OtdTs7bV42UorrKFWRavpzJ4edBpKLzT7pStxWq95oDLgOC
 MyHyn1TmrldWUqutjgjDkB3SEt1Cmf5qroBhshXr+5JP1YSXiQoCkqNg0yZg4ykuhXah
 ShoUQOdauZYy7gEnMmi/++oBdj7fUyGskDqqWMRvxSf0oX5iFwLEw7Gb5g+L65TdMrem
 y7Jg4HIUZM8gkeQdn5PTdpAogh3Mj6TklExBHfZlknGrwavdF+ns1KPnkJjUHOaWhlMq
 ShlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919706; x=1769524506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GXCnGV/8gnvvni4iSXIKKwOs9GPs/4AmCoeg5x0FRrU=;
 b=bSku9CIgt0yZf0YTNrxWCNUfQrmAX666cHgibcih0y6ueyaIRIv6Y+Im8nncTXIJbq
 eI7oYFBnyln3WMVXXkrZjR6kQfBCL7+Y05j9i+LXhnFB5eP3vmhJ89lhisElpy6kPtqR
 LY6PYyQXcL0uQ2N4TGt/kvi6TQBIw5t6zfNuYTE7y/rYc97dxKUohByTf1OiVM8vAiFg
 XsKmBhSAIEbjQkDa/+1qZchQmD8Vn4mJhqYULYn18I3UYvYK2+KeyTVs3XCSHNYPoFzd
 brwlXdxhh4KGSih8f9ZYIropztTHyO+X/hd4HjKu8ZtlPo4pJFj/VHNyedC/DBzJQ9LO
 K9Ew==
X-Gm-Message-State: AOJu0YzhHaLd48TaPwPeUWBo6HgHLUsGr/9kJlXDeSpLNC9fwuY6iVb5
 JT0tl1Pbxr/SxlGR//1PCE1uTgQ6bwDgfsMgB5qauQzi7EEBUu6Lf7Wvxnep6JnRHwk=
X-Gm-Gg: AZuq6aLRp8KQnP74+FTe3+b6pJgawdLNLBBOSZXO2rHNIjpdYfgWoCn/0uobeoCtFLX
 90fEtVp3mDGrR76hP5zpStWM8IKQlgdf5f6WdD/QFHjtBH0hLf7AXE5wZNfoYCqjYFSfULVyGaJ
 iQlAjiUHUZmsTV9PGAHOspQ+XkuQYxBG9LwOdCYxpLD6C3cuf7wzQ69pNDLRIHDMXlZbd8IT6LP
 AGkBtCpf2NFliS14uJAvZydfnCKG8fof2WAsBcE9gg9D5/kXmroZa/9NYEVp+yO8v4BsH0OSJYg
 Zu0EtLJzRaBlSC+AvbCgJ5NAAKGQzvxTEyke8qFxAuVE/zEwwal/WEVaj2khHS8RWYEwPaSyul5
 ycypzYTCBWe75jePFl+Zto6Bie/uf0A2eNrKGHPEnU7ICJLCQgpLYLq9tYUDze8jUbreeqOa524
 yINFHBF0VhsbarfwSFKySLtOH+RdlhNE6oRI+OEBc6afbIBzMZM+zB
X-Received: by 2002:a05:6000:1845:b0:431:491:7e8c with SMTP id
 ffacd0b85a97d-43569bd30cbmr19300944f8f.63.1768919705248; 
 Tue, 20 Jan 2026 06:35:05 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595609c8asm1795585f8f.34.2026.01.20.06.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:35:04 -0800 (PST)
Date: Tue, 20 Jan 2026 06:34:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com
Subject: Re: [PATCH v2 4/4] doc: add PTP IDPF documentation
Message-ID: <20260120063459.58bbd87f@phoenix.local>
In-Reply-To: <20251028060758.233929-5-soumyadeep.hore@intel.com>
References: <20251024120840.420016-5-soumyadeep.hore@intel.com>
 <20251028060758.233929-1-soumyadeep.hore@intel.com>
 <20251028060758.233929-5-soumyadeep.hore@intel.com>
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

On Tue, 28 Oct 2025 02:07:58 -0400
Soumyadeep Hore <soumyadeep.hore@intel.com> wrote:

> Updated the IDPF Documentation with PTP feature.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  doc/guides/nics/idpf.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
> index b99cc18188..e76632904b 100644
> --- a/doc/guides/nics/idpf.rst
> +++ b/doc/guides/nics/idpf.rst
> @@ -109,3 +109,19 @@ The paths are chosen based on 2 conditions:
>    A value "P" means the offload feature is not supported by vector path.
>    If any not supported features are used, idpf vector PMD is disabled
>    and the scalar paths are chosen.
> +
> +Time Synchronisation
> +~~~~~~~~~~~~~~~~~~~~
> +
> +The system operator can run a PTP (Precision Time Protocol) client application
> +to synchronise the time on the network card in ACC
> +(and optionally the time on the system) to the PTP master.
> +

NAK
Don't use master. DPDK has switched over to the later terminolgy
