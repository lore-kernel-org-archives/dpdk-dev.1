Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F81606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KZ/m9exf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 220F640281;
	Wed,  4 Nov 2026 11:31:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id EE7124025A
 for <dev@dpdk.org>; Wed,  4 Nov 2026 11:31:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793788300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5z4oBr2Z4IlL3rZQ6t3KMHiKMqeac9zaZ2ebRmnrONU=;
 b=KZ/m9exf1yQl8jK3l89Ufj9VXWbAM125mfJl9dT9E9mU0SOAlqV94/SVmh+5RgaGE38hmV
 0luoPfblwxgU7skluQG+F/wEi5UZTcdoZCQLHMpOO8bTlIP5qVi4Qh42eeOEccUo8BH/FU
 eUekca0/IuduOiHv11pDb73uqcV+nls=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-3JXNZ-CVP0Oq8vXbU4gUSw-1; Wed, 04 Nov 2026 05:31:38 -0500
X-MC-Unique: 3JXNZ-CVP0Oq8vXbU4gUSw-1
X-Mimecast-MFC-AGG-ID: 3JXNZ-CVP0Oq8vXbU4gUSw_1793788298
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48dea677afcso230286f8f.1
 for <dev@dpdk.org>; Wed, 04 Nov 2026 02:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793788298; x=1794393098;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5z4oBr2Z4IlL3rZQ6t3KMHiKMqeac9zaZ2ebRmnrONU=;
 b=O5DNWPH+Oq5MWPfh5EX4f8XXojfzW1XtgdooOkB81wyYLAV8PBXn10qP1gNPIlup6C
 tc1s/TUCOUamHtEguO9sOcmhME5XAh6ps3ZubqwlMUwCCE1Vpkg/FjhkOQswerKEAY56
 4DP/tQ0pcDW7PJXvGl+ulcuSdOrMJmabezRUU6fNX9mELz5Apazawx97BLW5pqksDZAV
 kTt7zFPZ/uonvFlp0xfTpkeA83x0sBETJuPSD/0l5ese59JVomfiCn+fRMH3CWKMwl0a
 0A8P715p7SfcXtVmy7hw/xhJbiEZgk3mBusciLpBfD2eIyNyTPSMbnmePYJ1BVUvne25
 6dDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTCABAP53hGw134Tl1WW2GNPC1eC0Rf03cRE3X1jH+quGavJYlKPW4FNujyX7a7BuTHtg=@dpdk.org
X-Gm-Message-State: APuU4Z8bEnT820uQ7xAlUD5BzZH7uKt8hXHIVaziO+ZBQkTRRrngGhDP
 2s8+id7t9/dPWOSHyif+RlMHLrVQ9Y+9E6q29RQczR29rrNowC0CI3GYVhwBuJnVDhbHxT8EwoV
 Hl9UCGRvcxn6ibSyC0pW22RBwSi9f39cr+WvP7j6ECr0O
X-Gm-Gg: AYBFou2whspXvz6mjwylaP0Zhal1GW87EprEUXrNoNggDfXN7VCAreDMue4CyO/uVH3
 GynytKKZaY31TRzFR6w4MbzEm9dQcWlUt/UsDsh0E6VbbdM7zvf6F2tc1W+sDVpvquTQh5OHK91
 eDA4DeFGyvFksDcVPyX7xtPPs6xWpHn4huM2M5FOkSvJy87/oOlUQyekezce/fExqYoK6+tnl3j
 t0PEXcBot/BBZMEiMPzMEQyHec5pcJsxr/82M32UtfNuM4mhnuxwZmifYfqTxGqv3jAmXcEWKFf
 MV6wNcxFQ7Q3xblQX0vryEF02uXNcScZql2LLxBkjym0yef543EVR9HlTRkjun6tyfVPL7mBWPe
 kJJHJFTBMldS0bkdaiH9Tk5SLPEBzga4zV0yu9eRpZoVwAFieAl3PcmgHenpVoYN5hvxv+WJhT/
 oyeEPdRXcQAQEKxTTXJ+HNKVmltKNLppg=
X-Received: by 2002:a05:6000:1843:b0:48f:c595:d51 with SMTP id
 ffacd0b85a97d-48fc5950db8mr4540660f8f.14.1793788297654; 
 Wed, 04 Nov 2026 02:31:37 -0800 (PST)
X-Received: by 2002:a05:6000:1843:b0:48f:c595:d51 with SMTP id
 ffacd0b85a97d-48fc5950db8mr4540605f8f.14.1793788297141; 
 Wed, 04 Nov 2026 02:31:37 -0800 (PST)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d8748sm3122488f8f.16.2026.11.04.02.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 02:31:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Date: Wed, 04 Nov 2026 11:31:36 +0100
Message-Id: <DMMCVR2T4H14.1K8EVYFZCCHLN@redhat.com>
Cc: <stephen@networkplumber.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH 2/2] net/tap: fix use after free on interrupt handle
User-Agent: aerc/0.22.0-38-gda2e3af216c4
References: <20261103171730.1361878-1-david.marchand@redhat.com>
 <20261103171730.1361878-2-david.marchand@redhat.com>
In-Reply-To: <20261103171730.1361878-2-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CemWGCDXj3qTMhbzLL6Mzhye-gAWv9yrrtmbCY67RBk_1793788298
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

David Marchand, Nov 03, 2026 at 18:17:
> This driver was not unregistering its interrupt callbacks when closing
> the port, which now means use after free after the interrupt handle
> is not duplicated anymore by the interrupt thread.
>
> Fixes: c663018eb7f3 ("interrupts: do not duplicate interrupt handles")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Reviewed-by: Robin Jarry <rjarry@redhat.com>
Tested-by: Robin Jarry <rjarry@redhat.com>

