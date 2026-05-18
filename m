Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A963CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 18:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADBCA40662;
	Mon, 18 May 2026 20:00:49 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 4392B402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 20:00:48 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso463371eec.0
 for <dev@dpdk.org>; Mon, 18 May 2026 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779127247;
 x=1779732047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+X2KLc36CDfAZ4KVWWvsxknezIxYxVsQk9nXj29nvM=;
 b=lasa2eeDkqnMYyvNI+0GV+aGloCsRTZBe9Lau1Daai6wUitZLjBQypf1FiWkew9WAD
 iEAZr5swZP4nWEaeuotY5yspW0nzs3sZEvZRzxFp1+dzIgmIxtQ+Zw8eMGvDWr/NpQ/5
 VfDD50eT8upLtcR4sSy9oyM/Lb8Px1hjyWH6V5i5gAv2xLGlIPY+O0aINbAnbHCgKSXH
 y7fhFmNkKoNk/dkIrWhEp7gkNRyEKXb1CyrF16UIreNgihyZVVVq61JJVThBrueORvp2
 2DaCPQngQeC0UpjV0O4evwUOZR/f+Nd+4uelhqiQDZqR1gY4VcAINVTYVvPY8Xbovc28
 i2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779127247; x=1779732047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+X2KLc36CDfAZ4KVWWvsxknezIxYxVsQk9nXj29nvM=;
 b=IZatJoYUstEq9zi5hcksTNNnsSMk+O+N89jm3D4YCadpyWU05TGI4BTG+WLu0Ani4t
 LyKEFOZjaBgtsN1Sxm8BjoSecOKgUjfMyYO7d5bJtbz0ro4O5tjhxBbe3E0vE/yV0gYL
 kZuaWjI0y4qPkCi9ne8Jh/XY9r4PXMqPdfDP2wGUVAyh9BgefzDJY7eajTNZegtl554u
 IfpDYdvaI0oUwr1c5g2EuFvIOJduUBELE74QHfJqjktn2vMt8NkmpN/nuQXK1w2Zol8w
 u0hrVloo0G9L7ZGFa6GZHuLfIGCRD4hQyu7GBFREtI9EvSDmdTVdPzkN4ZrLQ0Gcl7zH
 Qt3w==
X-Gm-Message-State: AOJu0Ywp/OggYxqUKb0Q86xJYawlH7he9+tEjQP1g0xPySMJDKuGCz+V
 sYR6iJuwxu5uygNFDULTqgH+9NzMEqcEMYJthlR1mAU9FJU59XfYq1xKE5dhOsUHtkc=
X-Gm-Gg: Acq92OFRn/Ni5bfUv65bg6pWhtRDF4UrM6TG2nyZ1tRC3ySJDp3oXZQqCNL2VgS9F6i
 HMw9C1Ar24wxHXUrVvIlonj+cFpHYn64daVod3+YG/4s9PO2vgUvURzEGKfwJL6XoMLz32yNN6U
 +3sPPdgOw78FdA8DOWIsU5Xl81mha1NW4Evl2sS90P+h+S6zqtCqKFTuRvPt0UpOwA1ADQ3oPEj
 XeUOFmwTICpBk7SlqhSvEYrOZyzXlTIBrzgzT4e8IbIvkbzuI7rI8Z4cdqSwbdJsk7pgVQOGbUb
 roSneP/x5J57M6V0HEPwbEmmsHn+/RFyC7FnT00y3KY6A6TdkabhMBIsuEnwdvtZdeAjK5Nl3q+
 9xkaHrTYyaS01cqb9YZRQQYnsfTSypCpiAKihxpx1+hghW51HHTuRnQ0Dym0EddRnhZAx+JbRnk
 SXKTwv52p/xlEZTeGj9R10malmliX0ifTsK+M=
X-Received: by 2002:a05:7300:bc10:b0:2f5:5dd3:1fcf with SMTP id
 5a478bee46e88-30398157894mr7810702eec.10.1779127247233; 
 Mon, 18 May 2026 11:00:47 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30294500726sm13534613eec.10.2026.05.18.11.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 11:00:47 -0700 (PDT)
Date: Mon, 18 May 2026 11:00:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v5 4/5] net: parse L3 protocol after MPLS labels
Message-ID: <20260518110045.719501ce@phoenix.local>
In-Reply-To: <20260518132712.70913-12-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-12-rjarry@redhat.com>
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

On Mon, 18 May 2026 15:27:18 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> rte_net_get_ptype stops at the MPLS layer and never identifies the L3
> protocol of the payload. Also, the label parsing uses a fixed maximum of
> 5 headers instead of checking the bottom of stack bit.
> 
> Use the bottom of stack bit to consume all labels and inspect the first
> nibble of the payload to determine if it is IPv4 or IPv6.
> 
> Add test cases to verify this works. Ensure that an unknown protocol
> after MPLS (e.g. ARP) does not produce a bogus L3 type.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
Re: [PATCH dpdk v5 4/5] net: parse L3 protocol after MPLS labels

Info:

The local variable name `nimble` (and its companion `nimble_copy`) appears
to be a typo for `nibble`. A nibble is the standard term for 4 bits, which
is what the code reads and masks against `0xf0`. The commit message itself
uses the correct spelling ("inspect the first nibble of the payload"), so
only the code is affected.

	const uint8_t *nimble;
	uint8_t nimble_copy;
	...
	nimble = rte_pktmbuf_read(m, off, sizeof(*nimble), &nimble_copy);
	if (nimble == NULL)
		return pkt_type;
	switch (*nimble & 0xf0) {

Suggest renaming to `nibble`/`nibble_copy` for clarity.
