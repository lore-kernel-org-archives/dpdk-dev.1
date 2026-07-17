Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A0FC44520
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 13:39:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62ED840A6C;
	Fri, 17 Jul 2026 15:39:11 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 685DA406B4
 for <dev@dpdk.org>; Fri, 17 Jul 2026 15:39:10 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E578514000F5;
 Fri, 17 Jul 2026 09:39:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 09:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784295549;
 x=1784381949; bh=JMcf+GE4AZxMu4kNuchSoFw/124+mu+dxfMRX2t7QL8=; b=
 KkAPAYYy2MJbGDpAKFdLDj8NP+fxRS6pj8b/05Sh85XlTFIe/xfe4JyDolyOFIz3
 NJMJfCRvdg3BlIBxfm2CctR9MmoyXNA7pChHCHN1UDVJeWO60yVxJGjA3RInGi6j
 W6F5a2qDCOSyCOz9/8diKKJk7RSZGw68nmtKdjr3YcN3svMJJ7G4uB8Cim+GZA8s
 Do+x/ho3h1SfmfFCRN8BR+EJVmU7as83zImC6mAc55ndoXru8m9UqIeLnVK5Q+Bf
 Blj6Vd4/l7DbJQekEtJoyfM4qg57728o5f3XNfaLtrLbgmLQoCLQyj43HbfaiBqa
 RjTOngeWbyEXxZMDJqEvQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784295549; x=
 1784381949; bh=JMcf+GE4AZxMu4kNuchSoFw/124+mu+dxfMRX2t7QL8=; b=H
 mOoWsRZfzOT6k3XgsWbawrw1xplGIBJhGDgErvW/zTKn+t/U+FT6+kfDNQHL4Fhw
 kFvSX+NTWGeI3+eQXYNjuQEUX7K7E4eo9knUGb+T4A0gpJcEQf5511JFyltI9Vnb
 jECFhbIUxk63w+HsA+TiWHjGceBNdk0iWuO+GIc89DSdC2alHgqB8aak4qOlXd8u
 Qw3bCkLndmvLBjDq9qHMUOjhSkY1h+T2SwDy8zJwj+jr5NcJsR7lKtqFUGhs+BY9
 cB3iwho5zdGI8CfJa7pct019oIQQ8JZaAaB2T9NtCb9GuH1Z5ze8bgJwD082ijCe
 2acvM1yCHTh0Jd7E6QtEQ==
X-ME-Sender: <xms:fTBaan1xp3Bt7rLmcOtvIAO2rdBnf7mtRwsNc6nC58SLayUaIy3FiA>
 <xme:fTBaaqaLFQoThcacjAdab1xssWiZzdbYWSip08_yUtm6_PrRh9pBLyu2SYduuCm3b
 lAFTM-8GgF-bVT7HNXWSnNVyTw8ifbLIEOfTJh-QhP0AslTCsikbA>
X-ME-Received: <xmr:fTBaanBMQDOwfZYLLxXnz6n0rf14z0DzLh_KauWYGph3O3swfxwlvFbP60vvQ1E4VPj2g_edDLH1UdRPTg>
X-ME-Proxy-Cause: dmFkZTEgwglvb1O22yCA5vtyx7+Rml1oVbBpfyxNb/xxI+slpxNMlWAeHbaJYbj0bAh1AZ
 HrIT8hSBe/TjAKfyRa00FbWtY2wXJDhlGDz30oll6uxwMtHQUSQXw1mxphHNeHL7NvVWDY
 U3bVH6VNCZChhL0iy/6nJq/kL/Ew2qNPLgxTOIWnDeAUs+d0xJt7kW6k2oMYf8FtkDfdzz
 tC/eQIh8oaCWwvRfuuFiXwbUp79v6tlRpJOI77lUKOEgX89IWfpTUKyk0ct9XLWX2jWdVY
 IqE5sWyx+t+9duzL4yzpswhNl3QxS0HtRoEodWeozxmxlrT+cxns3aPCLIKhexeOE37Kbd
 zeT1nZrllE9Ipl7gMo+WXXFA8D+1gqP7LRTf3rhQ4E7geQCwFDcCUSpk0O4Q4G2X9KQkG5
 JVO/6m9xyemHBrnSINlwThGYVQe5pv2zfXNqqfOfo954WmzJRvaCVcC9MgUG3sDpmBJopA
 ARR4tTaW/zEAwINBEGDqGUL9oyYWoQiMdCsuytlmhR3Q0syCQGEqDRjP4qkuxtEBgEA2F8
 k//2W3FtgLDbBwHfoPw/f2FHUbrTC7XQKgw97C3ZS5iwy0LaA9KKaBF+UyJzM/025yGgVy
 /DupYu11N0n/X1wSisVCUD8/IgQJSZU+p9NSfxZYVFWwD8knANmOK2mnGTwA
X-ME-Proxy: <xmx:fTBaak8jH-CaBufYhJx8OriLeiHurae0gjQhwMPeiLKUs_v_uJiang>
 <xmx:fTBaav8KTapIsRvW-vswwtRETrzrZluY3MwsW-uAluKwaJVDNRbtGw>
 <xmx:fTBaajdMjehxWJ9is-N4tMfs0hsq0R6OVe-cpmKkM3nUAhyHma9OfQ>
 <xmx:fTBaagFZuFVE3wl1EhITucvj9UBubN3N3M7UXPykuwX98tGwTbma-g>
 <xmx:fTBaal5ydwmyFvMBdOzYWgMIYWWX14d4o9exz3keQKu-XLmhOhz1DUVc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 09:39:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/8] doc: clean-up links in guides
Date: Fri, 17 Jul 2026 15:39:07 +0200
Message-ID: <rsRsIBITTgGy3qUk3BFbmw@monjalon.net>
In-Reply-To: <CAJFAV8w5W+VP3+vvBuYZWMnHKSftnxq7aYBOFVoa-rWm-FpP1w@mail.gmail.com>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
 <20260716103632.711164-1-thomas@monjalon.net>
 <CAJFAV8w5W+VP3+vvBuYZWMnHKSftnxq7aYBOFVoa-rWm-FpP1w@mail.gmail.com>
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

16/07/2026 17:29, David Marchand:
> On Thu, 16 Jul 2026 at 12:36, Thomas Monjalon <thomas@monjalon.net> wrote:
> >
> > Links and references to other guide sections had multiple issues,
> > all solved in this series.
> 
> For the series:
> Acked-by: David Marchand <david.marchand@redhat.com>

Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied


