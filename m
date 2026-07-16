Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E98BC44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 11:03:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8700E40270;
	Thu, 16 Jul 2026 13:03:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E4A5E400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 13:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784199785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utCDrhtj4Pud8BiBlS+RIPdfz+uUeKvSYgZc/+CStL0=;
 b=hhGhJC74nx8ltM4XgNsEX26ghkN8KAxomNQpPG0udh1OFMPcNXyHpeMzTiVe/5XWC5hLTY
 Z8PG9fdLYL398PrhE+VbFusYyy+UISyQmnJfihLSRnp2EnS3IsH3RLrwQRBOvyYNZqCfxz
 7wU2iZWKsqeIsxhVsnNzYB+sL/SXimw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-BRd8paUeNMqoQwkQCaE3WA-1; Thu, 16 Jul 2026 07:03:03 -0400
X-MC-Unique: BRd8paUeNMqoQwkQCaE3WA-1
X-Mimecast-MFC-AGG-ID: BRd8paUeNMqoQwkQCaE3WA_1784199782
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47e81aca584so3301134f8f.2
 for <dev@dpdk.org>; Thu, 16 Jul 2026 04:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199782; x=1784804582;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=utCDrhtj4Pud8BiBlS+RIPdfz+uUeKvSYgZc/+CStL0=;
 b=Uh45GhX2BuHYoPg9mRp37NsMarBS2HQFOaOUoSoszddNpzhaqYyiX6aFovRIi0a/YP
 VYC1L8A3Bx+prCM3Fqc28zdM0W1HEX+74vjpa5cyIaOqb5tKd7vVH17Ea1VsimLjnAPi
 mKTcjf4ru+DzXAJig8U2w8SgzjwUkl/9v1iMKzZ5o4NnHqXfR88m0crldbFI7HOJyjwM
 gMSBB8pN+DZSo8eWer1gAYM3aIiqM3+F6VOWIXJWUTpVA/iDsIrsfYPh6gGmCOi+nbFS
 gMcE3JSEXXPCK8NYtrFWIGGZnHYTJhwZT7yALocPf2MkugZwWEaZQjtVFYgP015MD1DK
 Redg==
X-Gm-Message-State: AOJu0YzeaM2CMxuLVmrl2xNVSaqtQI2/RmBxmsQVERG6TsmBsLsMw/oh
 qn7AQ/CPIoLGiGEdCX4zMETsW0/vzW+i3yz6xJt7OI4W8KBZBXF4WuKQIGiOFTz7SpMk5PxcNyh
 Kqu52NKtU5s8Du/jCM0BnHPmIQKnx7xtWFiE4IoQzn4Sm
X-Gm-Gg: AfdE7ckKy8D9zq2/5LAoKRuHym5k9KSNCvY/3mqQEGdH6fSLz0k1JLOWd6krX/a8wDt
 HtI7m4P9auQVjslZv2apVYZTkAa6uSrBgCBdUS6/uNpNDZU4MdPbPasEL8cV82t9OfsRZ5jYMSS
 sDsrVdpjM7vfhVihBCq3nsqwDgtCnxX55UUJj4/H/3XYvEMrg4jJZyOTwqhlBfhF/xqsoKZweEg
 taVcRKBoZXGrf3EXwRRXtQInQgQoG57A70GckDyAdC0QxJmob87S9wr56dtI1N9yUiY+6o708K9
 7VWmsQ/vTdJryfEZJbGYFpvTkl3tjOlc8MM7DnSbDqY+YpS5S5f5SKp9DLYHDEObqynYWCjAMrp
 Wy4pMXP9fBLOqKBWI9uf0+SerTq/2prgdVC1ftDEtgBuiQDRK/tE4PRsfGA==
X-Received: by 2002:a05:6000:26cd:b0:470:a7d8:75f5 with SMTP id
 ffacd0b85a97d-47f4fce31femr7964811f8f.42.1784199782426; 
 Thu, 16 Jul 2026 04:03:02 -0700 (PDT)
X-Received: by 2002:a05:6000:26cd:b0:470:a7d8:75f5 with SMTP id
 ffacd0b85a97d-47f4fce31femr7964769f8f.42.1784199781937; 
 Thu, 16 Jul 2026 04:03:01 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7f84sm22620957f8f.27.2026.07.16.04.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 04:03:01 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 16 Jul 2026 13:03:01 +0200
Message-Id: <DJZY1C07GJ4S.1GFZVJ01RL16D@redhat.com>
Cc: <dev@dpdk.org>, "Aaron Conole" <aconole@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH dpdk] meson: bump the minimum required version to 0.60.0
User-Agent: aerc/0.21.0-150-g6f19ced00800
References: <20260716105330.1612578-2-rjarry@redhat.com>
 <ali5V3LlVPtDNBny@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ali5V3LlVPtDNBny@bricha3-mobl1.ger.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RAJLClDnWOMivdahCWxztdSb2ih4-WuTYiMO2OOSURI_1784199782
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Hey Bruce,

Bruce Richardson, Jul 16, 2026 at 12:58:
> @See
> https://patches.dpdk.org/project/dpdk/patch/20251205121301.3443561-1-bruc=
e.richardson@intel.com/
>
> /Bruce=20

I had missed that one. I'll mark mine as rejected.

