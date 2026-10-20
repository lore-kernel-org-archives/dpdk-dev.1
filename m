Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26186606A324
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DV5V4z3q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5070040A75;
	Tue, 20 Oct 2026 09:00:10 +0200 (CEST)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by mails.dpdk.org (Postfix) with ESMTP id 7E74F40A6F
 for <dev@dpdk.org>; Tue, 20 Oct 2026 09:00:07 +0200 (CEST)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so937503a12.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 00:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479607; x=1793084407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e1TLiRo7aBYPHyuvX0uo1tolai8iaqOa5FVVYxGApPs=;
 b=AQYPOPw6VWMjPZYX4jzZZ8nHrsWr39z+e4BLGObPJdhnrpQz9JEYncTbHkyKa9GDUi
 4yF7P37Kpp3Wzojo62HSK1Qi5DUMjqqfRYku9xa3SnSOJh6ANre7nTVo0qOaXSWalhnW
 6Bt9/4mcvraCYm7ZOig8hW8lqAjUtkgjFo0wqKp4d3MoEfYdSbp8Z++ktceF+wFQZ3t6
 wfEzgFJM4m3RxLgpX8QXDeeag8auRoct78pq0Y2lLMxSDn0DOtz3cenugVCl67nQJzbO
 x97ob5fjhiGWfed7U+gpe+BlrTNRwca/eYvyPfInsKVJnv9LpZ2U1dkYgYFxSPcG4o7P
 qP8A==
X-Gm-Message-State: AFq9FYKc92WJtThp1FJM9IUXYRmz6zLWiuVzf/jAboXvxSvy+6xNYfYK
 uqL3tHYsv9/aPBaUFL1npUaihd0PDt0D2Xi+r0j1yy2zWWTILH3SWVi7pc0PKHNGt8lzN9HBgG2
 WYnQe6k8IoHnz24oD5Cd7PFep8BdRdmyYAfIaY1XwsxJ1dk/zTE53+bf4kWoYczOOsKLzNBqBbZ
 luT3hwu1L9fSv9heCyI+RJGiQoO4Yw+BNE6lPJKHLRf+LakBmHhrOgAAmV/pDm4RELic5cog==
X-Gm-Gg: AYBFou0JGfomWTw8UTgoG8MwQg4gZWAY/RjKlBOAxRehZ5vM59rsoImCadaifc0zXq7
 3hOTIBOMcHgulQhTtEOTPect0YAz86JiEl4ClQpBsvhnFXAPEkC177CnnqGovoX7Bo2BA6Qtrwy
 2sydtQZOUshSd2xshd1knurKewHizicSgvdCQkHJ5N7wzOy+/WWB4djvphhxtEnjuZUqN4ptDVP
 87NWQ03fox7MsPOIl4qt5Y1EaZyJGstTvzaNrKCQleFY2+eux5awEMJoInzavbKXSvGoCTEzlzN
 PVCKjnA61L0JULbBPcq7dgKDhx8I1X56Eiv5RQF1IpJV7Y2Pgyhla9qGEflWUaEmHk2XCwq9yQb
 lsO7r/Cs6Mgx4YlOyYTvfhr5JJXBtGJyTa1TpdRXv+we4HX9JmOHSEFjRGC/6v4tlXXDGVinXW/
 LgmCRIjfoggiJRe1ZT14P0MX2/weg5ER4wEi0=
X-Received: by 2002:a17:90b:53cf:b0:3ac:af8d:c839 with SMTP id
 98e67ed59e1d1-3acef15a0d4mr8011414a91.35.1792479606552; 
 Tue, 20 Oct 2026 00:00:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ad6c2ffbd1sm536152a91.7.2026.10.20.00.00.06
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Oct 2026 00:00:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso573269485a.3
 for <dev@dpdk.org>; Tue, 20 Oct 2026 00:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792479605; x=1793084405; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e1TLiRo7aBYPHyuvX0uo1tolai8iaqOa5FVVYxGApPs=;
 b=DV5V4z3qhnL8z8QC6X+lpaSglHv7Y326to1bQ0vcM75ZUvJXSnRKf++JbxcAusEu/U
 bwU0vT1oUEOfISYp6yDMgatwJHjMTcXJkwfp3E26DhjX+n1HbtM2GyOX/4mp301xVy2B
 0mBIAOLLLXYiV+SmYLvQSbf/bkGVExicn0Hh8=
X-Received: by 2002:a05:620a:6e86:10b0:93f:31f0:6a88 with SMTP id
 af79cd13be357-93f31f06e6amr882466985a.65.1792479605302; 
 Tue, 20 Oct 2026 00:00:05 -0700 (PDT)
X-Received: by 2002:a05:620a:6e86:10b0:93f:31f0:6a88 with SMTP id
 af79cd13be357-93f31f06e6amr882461885a.65.1792479603678; 
 Tue, 20 Oct 2026 00:00:03 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c04088680sm18319046d6.16.2026.10.20.00.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 00:00:02 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com
Subject: Re: [PATCH] net/bnxt: avoid maybe-uninitialized warning in flow
 counters
Date: Tue, 20 Oct 2026 02:00:01 -0500
Message-Id: <20261020070001.1068256-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261005235059.27176-1-manish.kurup@broadcom.com>
References: <20261005235059.27176-1-manish.kurup@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please ignore this patch, it is withdrawn.

The commit message refers to ulp_fc_mgr_sw_cntr_idx_get(), which is
not in this tree, and in the three functions it touches sw_cntr_idx
is already assigned before it is used, so there is no
maybe-uninitialized warning to silence here and the initializer has
no effect.

Thanks,
Manish
