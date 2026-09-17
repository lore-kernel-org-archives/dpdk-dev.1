Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DDDC982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:19:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 357F442F6F;
	Thu, 17 Sep 2026 18:19:59 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 3352B42FA7
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:19:58 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b350c6920so965824a91.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661997;
 x=1790266797; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w8Qj7iphQw0VA2oSndGL9eR7DjOIINYZpCBk2iz53qk=;
 b=aeVh59qZDW0zXzEL03he8ztBCE4baHi5FUN0CTlBrqtcBIcGr2AMICqioPQzshrLAw
 lb8meiqRlndjnTGkpbH4H6lbHhdaMN+pyjkLw2ZvjpsqLKYYcqnQvGB7g9njN8NRZSxZ
 Jlkgy/saYE20s79u0avdS6Nt2kb/cZGkSb2KSJR+HI3LjjgQnb/3Pc+3TE0EmJncT0md
 dW8Z2vSPd4mfUle/neCSziPhvNIXt4dID9ZDnH7jeNJPTzffE6itNk043CkNzfej+G5M
 YFuZkNQSfRnAHxYK1g4w27JYUJwvJj9iF3urXp7D7QJr11nlwrBsy4A4ZuRa6LlqY6em
 eu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661997; x=1790266797;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w8Qj7iphQw0VA2oSndGL9eR7DjOIINYZpCBk2iz53qk=;
 b=b2uZ+TgtJlIPdfAaDVn1MDf3iKfsPf4IsVXKSdr1W6F79Zec+Kwfg+q2HUT66OYZZw
 1CQmd76NXHEU5T24FSHGrzHa6txljAmUsbLPTMO0q1VQpV2Duxkhx4R59sS/Brcy65lU
 d4zRC+9/OuDk/MvyJg/bUNlqmpE1qlwambfR3qWBsWDc/fpN4bFU0QnhufwR+cGvJAtD
 Hs+86UfVXOHKZ30dmpu7UT0JRdIB/EDwtelGMRj9WGdGCkSiU4ed2MkG5Rs1eGyl2fFp
 jYX/r4YhVoVThOIgbuRqcVNKm2f0ZKr10rbT7PGHFHfCdvwX9q8VVrcKnp9AjI0d9PCP
 Prvw==
X-Gm-Message-State: AFuF++l/jdA1D+ZabeqQElHsbTEX9iKfZly1glt11GEQ7/eFkNo5RX6U
 i18zQqHhF1S7neMKM+VdlQK8XJvD05AB7BaRPEG0VYz/iy87wsoEPkWLihKPsldZN6TIMV/ekKg
 bpCEs
X-Gm-Gg: AYBFou0Z5WhGI2PqMmD0HOhdq/HGWq8QBbiuybkWL0G0YvDSysyz+qsKjfPoxkgW/Pb
 PTCkXlwf+sKkBF25Fbv/gv465wiV1OpanF3QCnOH4TaPm2ShvjwcWmQk2tmi8BaM2r7eEz/vkN5
 QKp25wK8nIBrp4Tulcoe3fwabzaSb4iLBlVQxXZ/8//hqI3+hZl0pOBVtTacAWgitjlUlTQRmFT
 crlAK83dyRDH2Zy71KObNv7VJmx519tSbgr3jXth07ZiSbBQ9dizAwY4hjz/YyqIsHCkbDq+W3+
 8u8pAurOXC3m+y+ex0xG/avq4agqI69BoDWgp3qNYRyaQQBiLlj8jIBWb+oYS/eDpaNtJevhA9m
 /mJ8WoLDwaSkGCJAmkmaeM9v4k9vxs6JQvjs6C34hGARUqbxJ20HBvu14AZ5vV6hC+D1ySkL7Cb
 sss09ZQJoSQm1fBYOM2HRcwMkstPRkZQp2p/Ra/VgQjyx/DGrcZr6n9K+iQC58m/4iSvcnB+VEm
 uLUFRrGrTF9VK1nCPkDjXoSQeO074wzC36YO8CM
X-Received: by 2002:a17:90b:4ecf:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-39e1e49a802mr16824168a91.16.1789661997290; 
 Thu, 17 Sep 2026 09:19:57 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:19:56 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:12:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>, <stable@dpdk.org>
Subject: Re: [PATCH 01/14] net/cnxk: fix packet length handling
Message-ID: <20260917091214.6f076e08@phoenix.local>
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:03 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> Fix packet length handling for reassembly failure cases.
> Also updated few macros as per cn20k platform.
> 
> Fixes: 5856f23129bb ("net/cnxk: support CN20K inline IPsec Rx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---

More careful review by AI saw:

Patch 1/14 net/cnxk: fix packet length handling
-----------------------------------------------
Warning: the commit log does not mention the userdata change. The
patch drops the "flags & NIX_RX_REAS_F && inb_priv->userdata" guard
in nix_sec_meta_to_mbuf_sc() and nix_sec_meta_to_mbuf(), so
rte_security_dynfield is now written unconditionally. Describe it or
split it out.

Info: the OT->OW macro changes are no-op renames
(ROC_NIX_INL_OT/OW_IPSEC_INB_SA_SZ_LOG2 are both 10). Keep them out of
a stable fix.
