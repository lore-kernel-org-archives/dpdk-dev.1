Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E6C44506
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A9EC40611;
	Fri, 10 Jul 2026 23:45:18 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id DC6D64060B;
 Fri, 10 Jul 2026 23:45:16 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 929B57A00FD;
 Fri, 10 Jul 2026 17:45:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 10 Jul 2026 17:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783719915;
 x=1783806315; bh=xu9QDe2JSujeJomZK71hMl+CYgaKsafK1wJCZ4o8Phk=; b=
 HJxw84/TL19YC1e1Qu08ZWcrG8UX+uZVcxzgL11jxm4gcIZpwbvm2IwxBHS3fotq
 UML0eB+d19a2eQZle/DbpQ/H/YJfnCmegTHfN3uV5tp6F+GN1eOAnkQszcG1C+v2
 l8WRXqcW1pIXuUwrG1Ump5rD3regWITVVi2Wjv4huhxwDJlHwU0fPfqeZEQMIDbw
 qHzpFmVHIUQvf+Tzr46MZiCViQd2rHjbCIChvZa0r4a6b63JJ77xT9kNz6mOV9Zn
 i05pKpPr3fJIIOyrj+4jLgC5g7vkQNBf4lNKecR9nngaHPeXFqInYFM9M6MiNhdJ
 9eLh6lcK+6YgHKKQtE6G3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783719915; x=
 1783806315; bh=xu9QDe2JSujeJomZK71hMl+CYgaKsafK1wJCZ4o8Phk=; b=l
 W44zRnibODYTnp+pMB263JZR1Q+Eaacd/DmZ9dlvcM16kCu8mzB3+RvJtvKRRovX
 XG9ioq2VqrPCk9KpZllqZg+bElQfgd0LpJ+VZgkHhsA9/IvjH8+s+b3HKGQGYWqh
 GMNqOyEosJrDZZylrvht5aJsbF6Evcf1TwFQm8ZNktOXEKGOR66LtTHD1REZYizV
 Ya0YeTUcxcRXIlR2GRC9TxvNjITFSd7ZytqTSjC4wJmSeu0e3W22oHIpTYVy0w2a
 K7vkbLatV938+SZ2Dak0IJvRNEIrsXy1vzFXIQVS+Z2PNC+E2qv2QczxPdMhpYqj
 PRiN56ayXZautZIuGmaUQ==
X-ME-Sender: <xms:62dRantdWsgXpNqga5WucQp3qjFXiNjufaMVvPOvkYpo86nCtAadbA>
 <xme:62dRajZuCuXDUJEYJ-76XdI9wChq9mXhiboP5_cEjBrLDZEU5zPaPcmJI0N88c8b4
 4tyUzGYW1t_AjAaOyHUbxIefRDttsk31f1I_O0M09DWCjIgePS_Mw>
X-ME-Received: <xmr:62dRapznRWCyzmu-treGqIr2m7GA-K1Zqctb5GFj_ShnIRMhkkP8Twjkc2Tg0krEXTFzokWOshbxO5scBUqKwbbg1g>
X-ME-Proxy-Cause: dmFkZTFXhn0fQ5+B7WY88zY8gKV/XzSAHoDBoH7cc5Sq3A219g7CiTwIv1GerirRblJL8a
 ot+mEvGjZXZoQ+lxKCrAccl2vXLwKVhMY8cKxg7ql/MWI81XWluuKA144ZBvgr1XMmG5eb
 ekbz0Nh8AfGuVwFgH63LWNF50ZE0m0dFY3YJv6XldGBq9ZJzaROhvK2Xyhv0qQZrw/K4Zx
 ggumYiYs1jMyCVZxkCSefQBOQQGNPj1kvGuztufL5lDTT3guldVzc1Wr4yOzx6aNNJqY+e
 vxHPf5I2q71rCfB7Y0uumBb1PKpTnVHxtw0kI6fQR3jjDL+5we0LY5c2QYNK1mtZZiiopa
 pfZ3KhtsKcvg9OOrEECH+xnwYA0mDTmFrsUlq7pvNcKg8SCjWGpw/BlG3cCVui5aOHP9di
 mfRoWzvmkcGncE6M6wyjEHisuaNwXYAz84NnIBEvFCLRJWjJPTiFQLN/dfoeq5efRLTyI9
 8zljFVUijUdIl82YwPNYe9WEeidR00+tXm0iI5Mq4m94INXRkiIQsAekYIT41B/PK9bcCG
 3Nc6VnSG/L2LAIFGF4432W+zOLEtpjf11iXXEXrNIsNM1nerKkHmKqmH+t51PD4aRap8wh
 2R4NAHG01QYOVG49wxYi6eDuhCNu+i5V6hoWEgCz8au2aqryUouEbv84bZ0A
X-ME-Proxy: <xmx:62dRarjJd5bcH52_BbrGOyfbAbzNJL2lvG9UwNgT7Le58jKWOqCJCA>
 <xmx:62dRalkPICHf3CUGMYzSNUS1Sl63RzAZm939KECm044-fCNe_t8FRA>
 <xmx:62dRahjtK8sNI-0IfMP0aYu_caJnyplNB2DSZ-ZVfmCyifLvPVfK8Q>
 <xmx:62dRap1XjKKqBuffSoaZn4TPbq9ijA1xSzp--Qvv4jNFrcmEwP-XZQ>
 <xmx:62dRarPhgVIES8LzmVY6wDvW3yRPDEDQ7DaJ5UBTDReQqN4XFqNuQJAU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 17:45:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, rasland@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH] app/testpmd: fix flow cfg double-free after reattach
Date: Fri, 10 Jul 2026 23:45:12 +0200
Message-ID: <EJr8j25HT4mwZawFv5CL1g@monjalon.net>
In-Reply-To: <20260706115248.188551-1-mkashani@nvidia.com>
References: <20260706115248.188551-1-mkashani@nvidia.com>
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

06/07/2026 13:52, Maayan Kashani:
> From: Shani Peretz <shperetz@nvidia.com>
> 
> When a port is closed via close_port(), port_free_job_list() frees the
> job_list but does not NULL the pointer or reset queue_nb. If the port
> is later reattached and "flow configure" is issued, port_flow_configure()
> frees the dangling job_list pointer, causing a double-free.
> 
> Fix this by setting job_list to NULL and resetting queue_nb to zero in
> port_free_job_list() after freeing.
> 
> Fixes: 7fadc8039588 ("app/testpmd: fix memory leak in port flow configure")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Applied, thanks.


