Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150A3CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:48:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 583B84060B;
	Thu, 15 Oct 2026 16:48:05 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id B5443402F1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:48:02 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1E2237A00B8
 for <dev@dpdk.org>; Thu, 15 Oct 2026 10:48:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 15 Oct 2026 10:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792075681;
 x=1792162081; bh=ypRcSwOv2FRFVjKobqKZafCX1YtXvv6bp2bP/9HbPDQ=; b=
 Foafzac3HSfqP3pVFB54rZzR0/3XWeifcyJHqi4Yeva3v/SPMjzQFnyK4yupUqrd
 6ZOcthkQpqHZj+p11wHJVdI76R6nyNcNK6PgBm+6BHDRrIO5PSBKTTpcordivx3z
 6Z3C9gDa5qb4avozroDJlYj+OBCZgoW+vX39eSQlXRxLKyA8CkBajFe2CRL2ar6m
 LXcRZ5FuuocXlnYwffsatKHaiR4Ty6UVPNynyMJArCvtT9OtAXEbmmnmpbxrH4Is
 Q5EKFEBYlvPrOCimIPWpinTlqBL9IUZwAotgFkw7cZUkN+Tc1yEKRBdq49LZk0wI
 RojGOOA6ubvKBqBcwxQlnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792075681; x=
 1792162081; bh=ypRcSwOv2FRFVjKobqKZafCX1YtXvv6bp2bP/9HbPDQ=; b=D
 BQnJycO1YFFaMTnzPbXOyBi4VLkmKP+vPcuQBb2SCndfXK6mg/zYGDKgxEKbS0gF
 1co+HNC2PQRP5eLzmn+gOenrvE1oqNfn+8ZvVsAvYryYq7eHVwXKzsW2+LFsiHr4
 niIWtnHfRhmGd4eakMzbkY7wNDNlRMEfserFXxnzVS/DpGkHOZEYqd3bCQfyqfWD
 njEJvoqFk8Dlf98GYkiXYKPr2oupN3iOju0wok0e8PolECuDUjEu9Nkb+lzxnGpR
 nJBEi/aAeVfy4rDmt9+evRl8P57cK6N5x/JzlvYHQLpIy4mgbQksOoNrAcgEelHE
 kU3xq+qhYUBIHHZ5clTOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792075681; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:GmtSvMMphy6oh8d+akYyZCpq4caxsM4JIvBlFtNxwFayQGH
 gKOKVaeWfOm7IQ/CsvG4VBI/o5qM2oIT126xTtVonzj6KBZWKQJXo5eHN/klIN4l
 19JxsujWLksRHUIdh1v+VGLRL7paCktwFrlyYdgxJchfPXwTlHMLD0XMLtrCRN4M
 4mNfG278K4wDuY6g2pr/JYd+/IrHAfLfnoxiXTMnTTocPzWxBWX5HMKd8ybUSsK7
 QKrI0QMtuG5Gag8HC11ObaOv6tll4enc3B3dpZE3RxqHDcqWFXf1FrBFvOXitQo5
 KaEvUlnyWTfUPBsKJ+GRNdBDQH8oLbM28sF6rig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:r8ajiSl/lLHTScpMolkym62vUjLZls2nK572YAK/NRc=:BKPfCeqgPXCbc9vxjOtOJEodbdFWUsRGz4Go8OYE/d8=;
X-ME-Sender: <xms:oOfQak-bZVawR2GQV0RIOQ7LT1-o91A0ksHMu2KijMopdt2Pq0ZaEw>
 <xme:oOfQanbzReTXA2j3I_8CVvRQmhIGX3NtmKDPXINGSsY1zPRkRsISDY-9VjWUjBYfI
 AEVUHJEhNKuHXSCo8dl1-2k_zbcZ5I4N5bsl6T8i_wyW4nwsBZzYQ>
X-ME-Received: <xmr:oOfQagpgDNxgxbnrBzXifql9LaFjZRBjgGHieIsqArtII__AeCrbE37e83qFEE1rzNzU2NCitkpeCCu3jpFexRI>
X-ME-Proxy-Cause: dmFkZTFMkWixB2jVidy9TZ7JXY8RbQ45moR0yn/8OdX6YcX4pjfE+hR1/6KJa9j15iSHWD
 r4vTDJvLDoioxprECAixw7ZKaMVfBnd5rJvuvBJMKkRqMtCvLfIsDIIMLwWKmxPsCp3lgM
 m/3ubldJJWc2HQsAvv0Z0FjBfSqLoXpS7y9cNyl47brxYjF1tspLolWNBqHxNXWJSczdA7
 uOH19ZX54l/93AamReJ/Wnu8/yg/59Y+FjsMPfLdOhcGHiErcwbQ4fSSirgozypsTi+/dH
 nBHAnFjYHI5bBNQ+FDn/72LxU0lvxDBewOsPpy+3R0UoBqtr1vhyXSENXqRY/8pQl5x9iX
 LzAVcCjJZmW+Vlf4vCWKWz4A/+fiI4njKQPLXOW3AV7C61sgRkEWWoWYm71zSXENhiWdPE
 Z61wf6DRphmmuIHItBIjTDRkdTEf+9JbYDwR1fE1SfJOTHV5Ci301ElFjUajhP+8J443+t
 +unmCwyO0Z/8rypnzguWPPOXaH/Yr7sMtCj53KbL0ti0LJqgiatBNWNvTY6N7+0jDpHtQH
 8lhuraOXgdBk3CHMxxLStnuDlw0SbBlPRC4UaEoR7MyH9C9l5DoLqBf7B+sfyd/A5CR2lW
 LbvSrDDA274Lfl2pmgToR0SZ64vAUhivJ5FEJNwGkEdphnyl8hcNtfj3YoKg
X-ME-Proxy: <xmx:oOfQavZ77qF77K4HrCanavvNjuLblWw2sKSr4BCAgGJbhdX1heNGBw>
 <xmx:oOfQaj7rUBvzd1EgyYd2fnXwWERrH9FrsDu0y9x9GUeF_MWLwFqhCA>
 <xmx:oOfQaqR0EFixtC3JkCbp6nEuPPnAMzJZUAE4cdJO04UEZCK1AtLXFg>
 <xmx:oOfQajvBs6IEFAS6Y-c5UyyDSQ_hdr7_eb10A2UwZDXMlf2tBjEWmg>
 <xmx:oefQaj8IHcpNtF9JhT9F24yPlk4GJk9OSuG0DLpC0of9iSIOM6HEpSPO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 10:47:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, hkalra@marvell.com, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Wei Hu <weh@microsoft.com>,
 Jie Liu <liujie5@linkdatatechnology.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Jakub Palider <jpalider@marvell.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: Re: [PATCH v2 5/5] interrupts: warn on leaked file descriptors
Date: Thu, 15 Oct 2026 16:47:56 +0200
Message-ID: <8xP1O1NrRjuCpZvWnQbRaQ@monjalon.net>
In-Reply-To: <20261014164313.1755520-6-david.marchand@redhat.com>
References: <20261002091758.2922227-1-david.marchand@redhat.com>
 <20261014164313.1755520-1-david.marchand@redhat.com>
 <20261014164313.1755520-6-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

14/10/2026 18:43, David Marchand:
> Let's warn on interrupt handle that still reference what looks like a
> valid file descriptor.
> 
> This will likely raise false positives, but it should help limiting FD
> leaks on the long term.
[...]
> +	if (rte_intr_fd_get(intr_handle) >= 0)
> +		EAL_LOG(NOTICE, "Some interrupt handle is leaking a FD: %d",
> +			rte_intr_fd_get(intr_handle));
> +	if (rte_intr_dev_fd_get(intr_handle) >= 0)
> +		EAL_LOG(NOTICE, "Some interrupt handle is leaking a device FD: %d",
> +			rte_intr_dev_fd_get(intr_handle));

Yes let's check where interrupt FDs are leaked.
The best would be to look for such logs with the -rc1 tests.

Acked-by: Thomas Monjalon <thomas@monjalon.net>


