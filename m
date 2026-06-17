Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF6CD98F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 15:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D329540276;
	Wed, 17 Jun 2026 17:46:11 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 36EA540268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 17:46:10 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-30bb7d20ad9so2964245eec.1
 for <dev@dpdk.org>; Wed, 17 Jun 2026 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781711169;
 x=1782315969; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vET+5cJ+BG0w8ukPpuAwG0sp9RDJp9KvybvXdOrNoA=;
 b=OHsbTwHqzLcfsdoa+hnaSoBHqy7G1wpSJvyKWFPfTIl6aF4csqnyfbYOKPCQGuh86D
 /Morx6tyzRzB6xJiznl+16vqPo+uS6F3eKLEeGPBB2MAFrJa0NuLUcrqqBTEOV0ViFrM
 mkvpb+3hR06ML39/vQCKhealHkVa6HQA3/3TywmOpLZwP/X0i9D0+AN8WnMzvT/jzCg4
 4SKJfCTKAAh8oSu9k19oF/A9/Q6lJNS/i7h8JpotGoOFDyq+UaZ7pYs7JYMadwZDMPg2
 HEfPAMFCJpdiN5MgYX3aWkFJ29z/HMRzL0y4d4ysjT3A/0dd7NuEI/KgDkBcBVmy4KmU
 FuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781711169; x=1782315969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+vET+5cJ+BG0w8ukPpuAwG0sp9RDJp9KvybvXdOrNoA=;
 b=P6cWhLaZM9aiNEZYhqxQ3NkdmiJ4rwsabhhNqsE3lh8SFMmQjfEX50o2EzOI2jSQip
 45E2jqYtczu7h7wIX+hxOGmGn1+oDnSMrl/uYn/cXwGVmh42NDBS0rUfnyv8m5fiFczH
 GhDoenZjjW10Rn/2o8bzXMJskfWpXTaJgJK643kyU/KAaYjTU5PyakhQZIl7bGvNWcrw
 +m+aSL27DzjigB4KJ4LaqxEFAMBu/5gCVZ/pJXc1f7uKwmKwbQEI8bE2JM5BuK/+IxN+
 2UyV10o2ks5q+hcKsxM17AWUBwnT4UmhdbRUgCHBvCKgULNDch2xDPXJOssh6X53Y4+G
 FubQ==
X-Gm-Message-State: AOJu0YzviOci6CIlA1kYM6WwCnqnCM94yhNaBgAcieSAyWDWjMRnpbiq
 70UHY+tw4/1u+AFk0gswIrvpO/EHZT4wly9Edtp1m9uey3yaM6hxrarZgCB/VfGeCY8=
X-Gm-Gg: AfdE7clkaHgASk4khW2CUm5ujYioKMZAqkfUjri1kf/nSH7nvvXvFSVyvzqFe6ZKvqY
 CeTBoQ6GQbKO0yqLZ26uEJLZyQBhxWDeMyt0ysRSaG6XaDFOk599Zrha329RNx+NXtyAuoLB8mU
 8bq0UCDVypXTZwS2sbf8s3n7F43JTQ2jI18whvw7TlFyfXD16NkbYLT5yisfsNGSqzZa2mhvhrd
 ipBlKQ8KUakqgdhUms0vfLkVihmNyT6MvUjKzbsBBhz73+0TteQmd4dpOIdaEwItkOlSBOrCccI
 KXSwmm3rmyJKnomLaH+wsCZwZqzoKqQCG6rp9ChlXK4sjw0F7fZGInDiw1G/sZR0KZgm8gzBUWi
 ibXvQiQ8acO9dJuxwlM4AiMvH9xpPVQ09oJytr+IHX892DwEJ/hU+rIbxOePohh0FrTAHjkgXUo
 +J5WW+qZFvGu7bTp3/Y2Msf6A3M14OKKAxHEatssjP6KldFDRyZa57qQ==
X-Received: by 2002:a05:7301:5f84:b0:304:9b48:53da with SMTP id
 5a478bee46e88-30bca06857dmr2390411eec.26.1781711169005; 
 Wed, 17 Jun 2026 08:46:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bd8ab412fsm2521702eec.31.2026.06.17.08.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:46:08 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:46:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <yangshuaisong@h-partners.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH v3] app/testpmd: add VLAN priority insert support
Message-ID: <20260617084605.2df08320@phoenix.local>
In-Reply-To: <20260617085247.2204050-1-yangxingui@huawei.com>
References: <20260616131001.2955655-1-yangxingui@huawei.com/>
 <20260617085247.2204050-1-yangxingui@huawei.com>
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

On Wed, 17 Jun 2026 16:52:47 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> The tx_vlan set and tx_qinq set commands now accept full 16-bit VLAN TCI
> (Tag Control Information) instead of only 12-bit VLAN ID. This allows
> users to set 802.1p priority and CFI/DEI bits for hardware VLAN insertion.
> 
> ---
> v3:
> - Remove TX path validation to accept full 16-bit TCI values
> - Rename parameter from vlan_id to vlan_tci in code and documentation
> - Rename struct fields tx_vlan_id to tx_vlan_tci for consistency
> - Rename token variables cmd_tx_vlan_set_vlanid to cmd_tx_vlan_set_vlantci
> - Update cmdline.c structure fields, TOKEN definitions, and help strings
> - Add documentation with TCI bit layout and calculation examples
> 
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Suggested-by: Chengwen Feng <fengchengwen@huawei.com>
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>

Added to net-next but had to fix one thing.

Because you put Suggested/Signed-off below the "---" cut line, git
trimmed away those parts and had to manually add them back.
