Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28757CD6E57
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 May 2026 16:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25E8040264;
	Sun, 31 May 2026 18:35:53 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 1FFC94025F
 for <dev@dpdk.org>; Sun, 31 May 2026 18:35:52 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304df7ff4c2so1875532eec.0
 for <dev@dpdk.org>; Sun, 31 May 2026 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780245351;
 x=1780850151; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OS8Pp5lI3cVLgZbntegX+KMDRyHQTNAX8rRfyuP7rc=;
 b=0PtBHHZy1HyHyHWvzp+srcr3USqV5rVG9GDq4qHJHRpIRXnuvbtuixUCFLc/FfMoeP
 vZXPGR4slBLy/pjGhE9+/CApf+b95CBjE+yTwtvM1w6HfIsEnaJprrMXFcu9mtjRQxQb
 dIIF3Ee1fUr7JYYrMPhQ2+bHbpXckvQzuhClDbxh2lo6c3KgqFfYcp7rDUaPccowZbq9
 pZWYwVNxhhaGThk2tagHArOZrO22uoH7TZZwaMp5RzCn6Vtc8ABSQMMD+Lk3HwbB4XKW
 1fU1Y+YNsD1nSuTEkAPzBvrmmkslpNdxOZWyJIEKnsYNCvZnloZg0qvS1jauE+AnPEwz
 56Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780245351; x=1780850151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+OS8Pp5lI3cVLgZbntegX+KMDRyHQTNAX8rRfyuP7rc=;
 b=aepTjQp4aY2KrXi7TdY0rWE76+dqnIB0ZOvcpqRt1DadO5zTphGr1NHCFja4RQnk0T
 aE7ANNFd3/afVMc+Xi9lNgN5OCXeq3Y0KZSE1hXX0gcL1WVmvvZmARwTWCLEO+dIxWEm
 sOiMyDF/+cDInWzGHjZDEY431W4MXvl7dNIszNmpdlD2oTW+EBr9ZM5j8rTB0kLRnQBF
 CCnzGgg4w1+ilLYaSyqU+KWwP+B/ifktOcw4uK21H+deDsa1IYJ7HvWdyUS+dCT50Ve+
 tZxDKSUHHzeAr4SO3TYfQPyZA0Ls1S7ePi4U2J3BnBu48KGCA1Efcl3eAdgHJftW6r3R
 5jPQ==
X-Gm-Message-State: AOJu0YxEOIqxV3ei7nANBOZog8eYpIMzFzS3k1hUukfPJWZfgVV4BrW3
 lYUl2Lba0dftFUMMiY8baVroYTNWYeDTTqtlK3PvrIKqkJu1/67dBTVquJVEJW3OpZQ=
X-Gm-Gg: Acq92OFVNpBq38Hz40gi+sMKBrrwvUvl3DgW/y/yiFkn3zvbHLN7o3nMtauA1OvSwNT
 czYwZXcKPXA/gfdT6HE7sP4G1nTg3LE0TcA5JYSVvB9WyV+/RBodfxP2spwWOyWt0PEYEsDYT69
 ZpTn4wVSeqszUqm+MTywla3v+LgkFnDJ+R52ae8r8/0ICw+PxFjkyUQaAA5sIpG2VTtJ5NB6fSI
 KPHIBW3WbCAlb8+P/Linn//mdoWNBrEeoL15eU06+0LlKm4UXaYl2lq+LR89Zmz63LxeDU6N8D3
 QC3cPWbs6ClW66B/bONCGdTF3Jsz91QmegRXiKho/++25nJ9HEMpEZhJ+zVptwpKZbUuhYp7yp3
 2/yCnSQBmuiAUN6tBEZS3uGtSvjxzKG6k/xrZkyem/cpcuPCjc8fAHkhODBz67xIJXmgZ1EcAlY
 w9V3urDgZFOiNbvjj/Iory2foj9+azCTPTDH6h7Vm2wrydosHue4sP+4GcH1FYxwKNQgiR/TkUf
 n4=
X-Received: by 2002:a05:7300:6426:b0:304:c9f1:a0e9 with SMTP id
 5a478bee46e88-304eb115e9amr4934195eec.9.1780245350932; 
 Sun, 31 May 2026 09:35:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a114dsm6932000eec.24.2026.05.31.09.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 09:35:50 -0700 (PDT)
Date: Sun, 31 May 2026 09:35:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH v4 15/27] net/netvsc: replace rte_atomic32
 with stdatomic
Message-ID: <20260531093547.6b5b7275@phoenix.local>
In-Reply-To: <SA1PR21MB668328954F3A75443CD9AFC9CE082@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-16-stephen@networkplumber.org>
 <SA1PR21MB668328954F3A75443CD9AFC9CE082@SA1PR21MB6683.namprd21.prod.outlook.com>
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

On Wed, 27 May 2026 00:29:55 +0000
Long Li <longli@microsoft.com> wrote:

> > @@ -59,7 +59,8 @@ hn_rndis_rid(struct hn_data *hv)
> >  	uint32_t rid;
> > 
> >  	do {
> > -		rid = rte_atomic32_add_return(&hv->rndis_req_id, 1);
> > +		rid = rte_atomic_fetch_add_explicit(&hv->rndis_req_id, 1,
> > +
> > rte_memory_order_seq_cst);  
> 
> Does rte_atomic_fetch_add_explicit() return the old value of hv->rndis_req_id? If yes this is not correct, as the rte_atomic32_add_return() used to return the new value.

In this case it is harmless, the req_id field is only used here and
it will just sit one behind the last issued value.

The do { } while (rid == 0) loop will absorb the case when request id
is zero.

For next version, will just add one; simpler and avoids the need to explain.
