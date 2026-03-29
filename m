Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22704FC97E8
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 19:46:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7E7D402C3;
	Sun, 29 Mar 2026 21:46:28 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 0FCAF400D6
 for <dev@dpdk.org>; Sun, 29 Mar 2026 21:46:25 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2c17446ba8dso2273577eec.1
 for <dev@dpdk.org>; Sun, 29 Mar 2026 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774813585;
 x=1775418385; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vwJ6xdo4Mt9BShyUkBY96KxfLYnBcqd/1CazaJmlN0=;
 b=v55o+CIKMOUMauJC4gDaDYGO1CqWOJadWhpYCs8m1/aYkZT139+6PRwkw8Cr5APsd6
 nKn2veHru9OKp9dk2/6NpTAM7I3rBE/8Re5MeVNS29fwwkCER5hl1OXvzFxynZgapmlD
 3ifOYJ0mmohQv1dQeYvLm/JgYvg+YAqyoEyLy7MyqomVfeA1vmfoCC+kkGRtTgDmppps
 OI+Cr4vNuYEvXgemAkddPPS8ldGFrkVkXhqyIx8bQ61b4QFnhIJm0cAgr1/07T0eTnf/
 hEuXFdzoqY7cCW4niv2gxn4XYGo5w9rPXDS/XNBsv1ZBJTOJLtgxR536GfcgIkV09FF2
 ZV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774813585; x=1775418385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+vwJ6xdo4Mt9BShyUkBY96KxfLYnBcqd/1CazaJmlN0=;
 b=Y0UllQEigSf6HMWUehhHEUGI0/POBBNsEly0LMyRSzpHl2R/BNBPJYYlAs4O41gzBR
 YvtftNo7heiqYQqCAyw22Tm+/5E7sdL/abDhWQ2E+JuVjg1u6eASCl7DVAv+DLs7getn
 jgJXqH7p57kzdp/K6vVz4hEhqGma4VOewFNQH99BqLEtjRJIIluylM9HDg5vHy1WKxEB
 YeT5z4ZVscKfuDknSXmtqGfdQWjQbmw91h2RA7HjTBGAOpiHU5schZ8P3zJXJF5XiomM
 A6Q9p8OaPllG/KwE5t/9lq5xsuke2gtia9htPpl1Sf/sS05IQVDKcySKlsIb2HCwoq54
 4DYQ==
X-Gm-Message-State: AOJu0YwMf0PQzWWs8Td+6Y1cYip7uXMrDqUxcxlj1df9b3F9xdgKXzQW
 a+IkXwjuPiRx4S6ECQSUGFASrfyKGyNfWKqkH74RcWq1LEroPNkJZbi+nQymF2XgrSc=
X-Gm-Gg: ATEYQzzO43BOWHSpW54z2/OICBFdzZmrSuQUDWqaKr4UuFxw3uw04fM8Jpo+6U0iWwd
 AhGQDlYqBUgtrQm6z/VSsEkr8zlPmXOpzs4NTIsvFET4A5H3Uw3jUZn3zqK69ZDOpkFSga43kgJ
 Eiok2TMhd2Ii/AM/M1ixFYikoMoJ3Rw8Z0QYZHxH9W28mc6Ukn9ZyG0ecTLfx4HW232BEYHB4ao
 2vboM8wp69YINPhMosqHqGwGZsT/T8C77JroAfZcbSYrr1lcqgDZI738r22wARZKVQz39I6D99g
 C0fBDupXDj9GDU91BalHcE49mfJ+9G51a2d86pqANmk/NMJ4k+tjc0tOre8Zla3coT5gmNfQJ7u
 qJodmUL4Htf4Fr7v1hcgIiIqZloPMqXJHC/XzBstiCrU1VfjC0lnKPjjGef3gPQKM2oWerjdcnv
 xSd/vbxL1ctn1ncmn+heExVVNeXF4rJyVVUsA=
X-Received: by 2002:a05:7300:724c:b0:2ba:6f16:10cf with SMTP id
 5a478bee46e88-2c17726234cmr5606596eec.14.1774813584774; 
 Sun, 29 Mar 2026 12:46:24 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bda13csm5123412eec.6.2026.03.29.12.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 12:46:24 -0700 (PDT)
Date: Sun, 29 Mar 2026 12:46:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pravin.bathija@dell.com>
Cc: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: Re: [PATCH v7 0/5] Support add/remove memory region & get-max-slots
Message-ID: <20260329124622.480af3c7@phoenix.local>
In-Reply-To: <20260211102433.694516-1-pravin.bathija@dell.com>
References: <20260211102433.694516-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 11 Feb 2026 10:24:28 +0000
<pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>=20
> This is version v7 of the patchset and it incorporates the
> recommendations made by Maxime Coquelin and Feng Cheng Wen.
> The patchset includes support for adding and removal of memory
> regions, getting max memory slots and other changes to vhost-user
> messages.  These messages are sent from vhost-user front-end (qemu
> or libblkio) to a vhost-user back-end (dpdk, spdk). Support functions
> for these message functions have been implemented in the interest of
> writing optimized code. Older functions, part of vhost-user back-end
> have also been optimized using these newly defined support functions.
> This implementation has been extensively tested by doing Read/Write
> I/O from multiple instances of fio + libblkio (front-end) talking to
> spdk/dpdk (back-end) based drives. Tested with qemu front-end
> talking to dpdk + testpmd (back-end) performing add/removal of memory
> regions. Also tested post-copy live migration after doing
> add_memory_region.
>=20
> Version Log:
> Version v7 (Current version): Incorporate code review suggestions
> from Maxime Coquelin. Add debug messages to vhost_postcopy_register
> function.
> Version v6: Added the enablement of this feature
> as a final patch in this patch-set and other code optimizations as
> suggested by Maxime Coquelin.
> Version v5: removed the patch that increased the
> number of memory regions from 8 to 128. This will be submitted as a
> separate feature at a later point after incorporating additional
> optimizations. Also includes code optimizations as suggested by Feng
> Cheng Wen.
> Version v4: code optimizations as suggested by Feng Cheng Wen.
> Version v3: code optimizations as suggested by Maxime Coquelin
> and Thomas Monjalon.
> Version v2: code optimizations as suggested by Maxime Coquelin.
> Version v1: Initial patch set.
>=20
> Pravin M Bathija (5):
>   vhost: add user to mailmap and define to vhost hdr
>   vhost_user: header defines for add/rem mem region
>   vhost_user: support function defines for back-end
>   vhost_user: Function defs for add/rem mem regions
>   vhost_user: enable configure memory slots
>=20
>  .mailmap               |   1 +
>  lib/vhost/rte_vhost.h  |   4 +
>  lib/vhost/vhost_user.c | 392 ++++++++++++++++++++++++++++++++++++-----
>  lib/vhost/vhost_user.h |  10 ++
>  4 files changed, 365 insertions(+), 42 deletions(-)
>=20

Ran this patch set through AI review (Gemini this time).
It found lots of issues...

=E2=9C=A6 I have performed a comprehensive review of the vhost_user patchse=
t and identified several critical correctness issues that violate DPDK
  guidelines.

  Critical Correctness Bugs

   1. Destructive Error Path in vhost_user_add_mem_reg:
      In Patch 4/5, the error path for vhost_user_add_mem_reg (label free_m=
em_table) calls free_all_mem_regions(dev) and wipes dev->mem and
  dev->guest_pages. This is catastrophic: if registration of a single new m=
emory region fails, the entire existing memory configuration for the
  running VM is destroyed, leading to immediate failure of all I/O. It shou=
ld only clean up the specifically failed region.

   2. Broken Address Mapping in async_dma_map_region:
      In Patch 3/5, async_dma_map_region assumes that if the first page of =
a region is found at index i in dev->guest_pages, all subsequent
  pages for that region are at i+1, i+2, etc. This assumption is invalid be=
cause dev->guest_pages is a global array for the device and is
  frequently sorted by address (guest_page_addrcmp). Pages from multiple re=
gions will be interleaved, and the contiguous index assumption will
  lead to mapping incorrect memory or walking off the end of the array.

   3. Stale Guest Page Entries in vhost_user_rem_mem_reg:
      In Patch 4/5, vhost_user_rem_mem_reg removes a region from dev->mem b=
ut fails to remove the corresponding entries from dev->guest_pages.
  This leaves stale mappings in the translation cache, which will cause inc=
orrect address translations, potential memory corruption, or crashes
  when the guest reuses those physical addresses.

   4. Vhost-User Protocol Violation:
      In Patch 2/5, VhostUserSingleMemReg is defined with a uint64_t paddin=
g before the VhostUserMemoryRegion. The vhost-user specification for
  VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG expects the payload to =
be exactly VhostUserMemoryRegion. This extra padding will cause the
  back-end to misalign all fields, leading to incorrect address and size in=
terpretations.

   5. Unsafe Assumption in async_dma_map_region Error Handling:
      In Patch 3/5, async_dma_map_region logs DMA mapping/unmapping failure=
s but continues execution. For memory registration, a DMA mapping
  failure must be treated as a fatal error for that operation to ensure the=
 DMA engine never attempts to access unmapped memory.

  Style and Process Observations

   * Low Memory Slot Limit: The implementation returns VHOST_MEMORY_MAX_NRE=
GIONS (8) for VHOST_USER_GET_MAX_MEM_SLOTS. While technically
     correct per the current DPDK defines, 8 slots is extremely restrictive=
 for dynamic memory hotplug, which this feature is intended to
     support.
   * Missing Locking Assertions: In dev_invalidate_vrings, VHOST_USER_ASSER=
T_LOCK is called with VHOST_USER_ADD_MEM_REG. This macro typically
     expects a string description of the operation for logging, rather than=
 an enum value.

  I recommend a significant redesign of the memory management logic to prop=
erly handle sparse region arrays and incremental guest page updates
  before this patchset can be accepted.
