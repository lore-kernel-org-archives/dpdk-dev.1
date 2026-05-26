Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D950CCD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 14:13:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17F01402AC;
	Tue, 26 May 2026 16:13:32 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 5B3A140290
 for <dev@dpdk.org>; Tue, 26 May 2026 16:13:30 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BC48114000AD;
 Tue, 26 May 2026 10:13:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 10:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779804809;
 x=1779891209; bh=0xmZullq1xD2xBE5F/zEE7TwUxBHb3Do38fAGOq+keE=; b=
 A5qQwMav632HJqzlRGqaYYiXKrRk/WAGfWkRwbx3NM6X1yT+7IV3g+HBcSe/Mohs
 R4y/c6wHFSjQ2jaLBf2EtjFg7KsLrpfNo47xzRqHqbjCroc+gwoU2nHUIfR3eeyQ
 dwn643yc0GxaHhZQhK5AdI3TKJaK0RC/uwAgLcePb6kHjpRUZrJ5OABQh+5nxpHt
 DpZ3CpTnWyOCRWC3JVEGKYEl7Kd6fbCyQta+7PIEwCf+sJGICmjI1IlF/BCoot/V
 heZ6q9EEtg4RG+3brBrSv5seBcFJ5Zrp8GjjLuM4BO/vDMoopFz1OhZg0NB4Ck2d
 2zgMpFIYcqJ3FpilxQbruA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779804809; x=
 1779891209; bh=0xmZullq1xD2xBE5F/zEE7TwUxBHb3Do38fAGOq+keE=; b=M
 PPYxgE8R3+5nf60FRB300sbOxcuzN86eaYXbpctulCdD1BPiR6uUYgacWjFiSkZG
 JUIWx3AvUp8mJzGdlCgc0JpqZsa25LWbkDQM7P87WIhbT88kwy/BIXipgjVDCIEV
 6rcq+4T5I99fMtwRsaLgwUvXe41IEvV4OltLaOi68vlhBpPOkgbkjyWXPvGD1voS
 alKsmdSdMoOta6v8+1bXVvvM0nuLe3MscZMjCPTqvBjK7nMV3thv6E5PRpbIw2Ea
 Jrq/K3dKsxiQsafrCjny4I1y8bkMlgV3N+aJgOTy607nZa3aXdTz4IEqNVUoRNO0
 QMPfGZXpNCCbyUHUYzMSg==
X-ME-Sender: <xms:iaoVauwQi2ncx9R_O0JfwjtAXqlVEiFLZ43krcNpEeZpkxzLh_rh7Q>
 <xme:iaoVaqa9iy0JQhAJdZiJ4xbMdNEFInqv0lq_HIJANOeNFiYzxq4MLYkEqO7OOV09d
 1CyiqUGlB18A82WE4LhY3lTd1Wtirc7tDyNvE3TsKibEgwQmjz6GA>
X-ME-Received: <xmr:iaoVaoTtvSfhWhG8xz9tVMdC_c9JGSrU_FjudWH_tYE5WdrlhQebmi8uK5a9T1AiooasvV0GvgWWkpMEgyktZC3C1Q>
X-ME-Proxy-Cause: dmFkZTGfG4czOw+DReMCi5HUpRwgvdayhy/blbsjkhWMjh3NTzVTNUq8pxtBaiCz2j6AWC
 JtPShoQRGtpkdX/VreFUMkpdH7dKXNS+kuMMa8yC0r0jPCDDHeqsAePJ808XMLsr4VSIO0
 aBbEok6FFt9JlWRA1MotsLDrJQQMqicVpD5rjLhuhaEK8e7kLbVx72EnXufS+pq4BCcWYp
 vIIelvvWyZicSX7tslSZWtT0dFJy86q0hhl806KnqtwqWwSvKsuLsuUMdx2EBx/2k3xTQU
 JPtiejn+42F7GhCHWe6z26FeMAAlazq/EbAsQvOJ7lQl3Y8HaSkfmH+CKzI441A1HBQdBj
 ICxb5SktWmoCsNvfEDhSuPpPU4LHN8KYp10GOsnM3+gcMtaqBcRRLewYkHgiI1B9AaLFKa
 HOcWUjzC+AJj6G3drkP3LwvO/7ZUsGfufaYUgO+Dk8mnrsTt0d6rPkHonjaTRbFHWqQynM
 mT7wEK0rBKADlqE/hOtfHNxlYD1luQcrIV8lb28Esf8HUbGyviD+2xICgySiS8plkFF+yr
 dTU4wVjBO/4hnlB/ryM6Mnz+uJ60VE+EWJmNoY7NRzDMBxKNSwAQBvvuTcibd6KRug9XOs
 pP7X2+eIu7tYHPnPmEntdRp2BIR3aVqHHu+pZlU7B455Safpf8YXvL50IH+Q
X-ME-Proxy: <xmx:iaoVasx5IWDgKjkvVNzqsJ_UXWXLcWbTrcHo8e1MQnyPH3g7O81h-w>
 <xmx:iaoVaq0xqJ9NSXWPwpb8m_mwsKWBgQxXLr9eMoZvm1tYUcHnpgwzoQ>
 <xmx:iaoVaq6i2sGWl4oNge02oWGuHwJIfxZJh-pVcWEFhixIBIHZDLgBNw>
 <xmx:iaoVatXN6IHmxsk8VD6mNVyFPxj1Cvic3y87DTe4e8-xFhi6z5Pwwg>
 <xmx:iaoVajzPhaUpdZZChUDbf0fK1QRuuy5QMpU9mLV1oYO5_fANbOMqoJAK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 10:13:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v19 00/11]net/sxe2: fix logic errors and address feedback
Date: Tue, 26 May 2026 16:13:26 +0200
Message-ID: <gMRpO5X1TMqg0ezYQiGHfg@monjalon.net>
In-Reply-To: <9XBXAO5XSSSHFRFv8zy4yQ@monjalon.net>
References: <20260519144810.3951202-12-liujie5@linkdatatechnology.com>
 <20260520021809.4019054-1-liujie5@linkdatatechnology.com>
 <9XBXAO5XSSSHFRFv8zy4yQ@monjalon.net>
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

21/05/2026 17:16, Thomas Monjalon:
> Hello,
> 
> 20/05/2026 04:17, liujie5@linkdatatechnology.com:
> >   common/sxe2: add sxe2 basic structures
> 
> Are you planning to add a crypto or compress driver?
> This is usually the reason to have a common library.
> If you don't intend to share some code between different driver,
> then you should not have a common library.

We are curious about your plans for sxe2.
Please, could you reply?
Will you add another driver class to sxe2?


