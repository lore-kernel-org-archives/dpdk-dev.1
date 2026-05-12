Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC25CD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 14:42:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA89B40652;
	Tue, 12 May 2026 16:42:00 +0200 (CEST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50]) by mails.dpdk.org (Postfix) with ESMTP id 797DE402C1
 for <dev@dpdk.org>; Tue, 12 May 2026 16:41:59 +0200 (CEST)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5a8891f0c51so5336694e87.1
 for <dev@dpdk.org>; Tue, 12 May 2026 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778596919;
 x=1779201719; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pd0DQGUgZrErnw8XS89sBufK7evSg5R+uG4UGX9pjBg=;
 b=lW6tIjPD3K4zmmmyUf0Q/EuGbPtax8YF1KlD6EGNmx4GV+MaR6WypGgUD/lQyLqkKp
 sIZUFatTe33JHxUdNvuu3GVkaMk3ByOd3UOtFaNoM0pHVj+Cnkcux/sfmm+OO24oQYdP
 pst9sQPe6uRRewjG66OcVvRuxnzXrxR65/ctDzBH3lxlx332oMTLNL22us/TMWYmrHD9
 fBReYuRyVyMz/0A4RSt3IOyPbO4y/XBE3ZhhQu/yAp29L/0FPuliB0HDodLshmhtxP5O
 ZvKYKcPnly5XEIhefyhjsAAYq3u9XKKCZKcifK6iaVf0ZYA4FVfe1z4frVSDzqTrTg/j
 XXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596919; x=1779201719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pd0DQGUgZrErnw8XS89sBufK7evSg5R+uG4UGX9pjBg=;
 b=OIB/35r3bxiORP39XxNhLpU4NAzkCZl2v6OdjjqMsD+O2uIBj01Igb9mIU/Y6surVC
 vW3EGZ+SLaL8XVR8PWtEDqOvDwLKlGeAbAYMI5xQQi6vCWbbQplJfKgZGBB08VjHZOtv
 3NKHYMnQ+1Ga7B7FAg7hBPM8+v7AnAbLv2AGDSROaH6L0SqFDIdiQocJPWpJY0kpt4RT
 n3zb0kiRepn0LRHAry7JQsMbD7IjaFkdBlvQ9Vzlt+5epR+mvYaxOo0sFh6UnZSuDdfX
 p+QbvFLF9eXWnOuv+JIt/8QgVNZjQ71xOhSoMsjcxSRZWXa3cI6h3hHX3M2GokTBTzQU
 iOJw==
X-Gm-Message-State: AOJu0Yxl1UiTyYR814zUxdrVhEUaFF+Az8HvSfKpRF4hRpRhJKUCr2Ox
 04ZZR/6GyFlrzfguOzOdlvXxTSuhvChmI2Htt4CvnrIE1BMufbV23miXR9DiTbS2A+g=
X-Gm-Gg: Acq92OGzg7rE4w9XdMXqBkr4EmQdgJ2w3V6bMVbTdQPz+VSBLSs0B4Wje4ZTgsemD69
 T4sc5boCOIuOyY7hZp8P5IYREZna36Fw4ZW5GTmKjr+iCmfzGrg+4lmWuJEFWC9wBvHzr0F2qRi
 omKJOFM//y19csDuu+4h0okXZlPeUrzN22QiOK00jqkKU1lXvOk7Cubix2ovgF9vkff9LP6QG7G
 SaxoRlrpKII6Ip+FIzy921LEtX7gQSLbgKWpdowxPKMU6l/8MV4C7Df29QzdDxNv+qKI9J5ZR/F
 ySzPM0ijlzJpW4APJjXefy90EOr86pwAqLs7Ot9o6naXs/L9pWuyfv3QodQBsuM7TCxJvG/dWlS
 2wPNQkh3FrcDXs4M6o1o+wx1fBgIiyD2PY4C+C6/SQrDb7YjlYFOF3epqjyy4k/DP6T1mqHJLb4
 0f1bYb8Jhn5nP2wYvCJNRQ2gvLi3VTyrk98uBRxQyg
X-Received: by 2002:a05:6512:1044:b0:5a4:7ed:3e41 with SMTP id
 2adb3069b0e04-5a887ce6483mr10015502e87.32.1778596918690; 
 Tue, 12 May 2026 07:41:58 -0700 (PDT)
Received: from stephen-xps.local ([62.119.255.230])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8c66facc2sm1940162e87.22.2026.05.12.07.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:41:57 -0700 (PDT)
Date: Tue, 12 May 2026 16:41:54 +0200
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 4/5] net/iavf: accept up to 32k unicast MAC addresses
Message-ID: <20260512164154.00d109c5@stephen-xps.local>
In-Reply-To: <20260510170306.3406045-5-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260510170306.3406045-1-david.marchand@redhat.com>
 <20260510170306.3406045-5-david.marchand@redhat.com>
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

On Sun, 10 May 2026 19:03:04 +0200
David Marchand <david.marchand@redhat.com> wrote:

> E810 hardware provides 32k switch lookups.
> Thanks to this, it is possible to allow a lot more secondary mac
> addresses than what is possible today.
> 
> In practice, the maximum number of macs available per port may be lower
> and depends on usage by other (trusted?) VFs on the same PF.
> There is no way to figure out this limit but to try adding a mac address
> and get an error from the PF driver.
> 
> Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
> accordingly.
> 
> Signed-off

AI review feedback; nothing major but worth a look

Series: ethdev: VMDq cleanup and iavf: 32k MACs / duplicate install fix
Tree: dpdk main (DPDK 26.07)

Patch 2 - ethdev: skip VMDq pools unless configured
  Info
    Doxygen of rte_eth_dev_mac_addr_add() is not updated to describe the
    new constraint that pool must be 0 when VMDq is not configured. The
    function-level @param documentation and @return list should mention
    that -EINVAL is now returned when VMDq is disabled and pool != 0.

    Subtle behavior change: when VMDq is not configured, mac_pool_sel[index]
    is no longer set to RTE_BIT64(0) on add. Before this patch every added
    MAC ended up with bit 0 set; afterwards the array stays at 0. This is
    consistent with the new restore path (which now uses the VMDq flag
    rather than walking pool_mask in the !vmdq case), but the change in
    observable state of dev->data->mac_pool_sel[] could surprise an out-of-
    tree consumer. Worth a sentence in the API change note.

Patch 4 - net/iavf: accept up to 32k unicast MAC addresses
  Info
    Release notes wording: "secondary MAC addresses from 64 to 32k" is
    slightly imprecise. IAVF_NUM_MACADDR_MAX (64) was the total cap including
    the primary MAC; IAVF_UC_MACADDR_MAX (32768) is also a total cap
    including index 0. Either drop "secondary" or say "secondary MAC
    addresses from 63 to 32767".

    iavf_add_del_uc_addr_bulk() returns an int but the only caller
    (iavf_add_del_all_mac_addr) discards it. The pre-existing function was
    already void so this is no regression, but having the helper return an
    error code that is unconditionally dropped is misleading. Either
    propagate the error to the caller (and make iavf_add_del_all_mac_addr
    return int) or make the helper void.

    eth_dev_mac_restore() now iterates dev_info->max_mac_addrs which for
    iavf becomes 32768. With patch 5 applied this path is skipped via
    get_restore_flags, but any driver that increases max_mac_addrs into the
    thousands without setting RTE_ETH_RESTORE_MAC_ADDR off will pay a 32k
    rte_is_zero_ether_addr() scan on every dev_start. Not a bug here, but
    worth keeping in mind.

    sizeof(struct virtchnl_ether_addr_list) already accounts for the
    embedded list[1] slot, so
       in_args_size = sizeof(struct virtchnl_ether_addr_list) +
                      sizeof(struct virtchnl_ether_addr) * list->num_elements
    overcounts by sizeof(struct virtchnl_ether_addr). This matches what
    iavf_add_del_eth_addr() already does, and the buffer is sized to hold
    it, so it's not a bug -- noting it for completeness.

Patch 5 - net/iavf: fix duplicate MAC addresses install
  Info
    Recovery edge case: if iavf_add_del_eth_addr() for the primary fails
    during the first iavf_dev_start(), mac_primary_set stays false. On a
    subsequent VF reset, iavf_dev_start() (called from iavf_handle_hw_reset)
    will re-attempt the primary add, and the new
    iavf_add_del_all_mac_addr() call right after will add the primary again
    via VIRTCHNL_ETHER_ADDR_PRIMARY. This re-introduces a single-MAC
    double-install in a narrow failure path. Could be avoided by skipping
    the primary in iavf_add_del_all_mac_addr() when mac_primary_set is
    already true, or by having iavf_dev_start() skip the primary add when
    in_reset_recovery is set.

    No release notes entry. With Fixes: + Cc: stable this is acceptable as
    a bug fix, but the patch also introduces a new dev_op
    (get_restore_flags) for the driver and changes when MC addresses are
    re-pushed (only on VF reset, not on every dev_start). A one-line note
    in the iavf section of the release notes would help users tracking
    behaviour changes between stop/start cycles.

Patches 1 and 3 have no findings.
