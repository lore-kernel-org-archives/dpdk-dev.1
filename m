Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F30E9D800
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Apr 2026 18:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BECB40285;
	Sun,  5 Apr 2026 20:23:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8539140265
 for <dev@dpdk.org>; Sun,  5 Apr 2026 20:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775413416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SiM0SsIH8fmdcW5kioLCH/AOzKym51v3fnJ9+lDl8ks=;
 b=Ye+yVOXIkJrHJZfsqLi+Sfd3j3ovBFBCqylU+4jZWsKQiJLDl1GpdCgQP5X1nPSZeMYISq
 Xw37H3ODa5F8N4mVoaMsrKKF2GZx0Ph6Yi+GQh1OJzW7YkwsFcjsffg/y+ZC5jMVeUQMPp
 KvVRy8jqNc6p/T4nqJFtcjyoKimf8dQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-w6FmohbyNj6wwbnOqg_RFQ-1; Sun, 05 Apr 2026 14:23:35 -0400
X-MC-Unique: w6FmohbyNj6wwbnOqg_RFQ-1
X-Mimecast-MFC-AGG-ID: w6FmohbyNj6wwbnOqg_RFQ_1775413414
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d1fec59c9so2204502f8f.0
 for <dev@dpdk.org>; Sun, 05 Apr 2026 11:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775413414; x=1776018214;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SiM0SsIH8fmdcW5kioLCH/AOzKym51v3fnJ9+lDl8ks=;
 b=KQJS/NK1mb+now5ycoD0HB1RGdBVbJR2ME8yA/0C4B0VfN1zm8J895TIkPskKIKJPJ
 Yw299r+7sfGubrr8TmS63BU2Ei2KewUhthq10/HKAXrhvJ8vXXtqxjLIgc9QSEuyH/+1
 nk6vRGAqirI60gpOAEOEd6lHGLTKyU3GXYDTChVPYKlwr2qfpXamTv4FLT7YOgYvi7Ip
 DPW3NbnWDKpJa7lGd1gGdeJVyb5OwmhOVvgrHbenmdRFQoomNqkshfAQ/RLr9tuUTg8H
 Y1wl8Ej36Vwc6TsGiNGS6uPunJKVkRxRP7Q6Eabl406U/1pFGhYuqPdDN9rWa6pxsNaV
 QxGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSN+JX7Dywyf2/AVWeeUA93i1yHMDigo4ND8cJSJveTfDlDOWGmLS+EHsqDj9ZrgnGbFk=@dpdk.org
X-Gm-Message-State: AOJu0YxGS+fXRheQxhCna5sgaroxmE4udnJu7D91wTccErc5RrmYsCQ1
 TQnAlqpizP2vY8kcd2oUNKn4eQCkDNbpiPBm2wGhpBVvVJ1J57kDdIgIPzKcM+uch6eIIyQmAvo
 ZvHXLFaAvb4dsNb1FITYAckzll0VLa2PAlJnh78qayWub
X-Gm-Gg: AeBDietZg47N2SnA/JLDlsZ+JarX7EL8ZfOqhADAg7TcK/loa6EWFPFcB4Rx0hyJsw3
 QpQqkTuVGE4vzJpzBh2r3LGMGrVVliHG9WJHf+t1kYpMZyfRMLMLetIfBXitUUHmYsSxHHxieIl
 zIKHEJSN1bS/NH0NxMuk2tLiCP5+234kFspzMUoDK4FImzhbmy6NsfoycTqZUsja2A0evVQOHjQ
 yiwH8t2IXdXynv0dZ/2kgcfO4FOccrWGJfekjiS8IznMAxa/Z9NmU/25E+3R9vOV8+X6mYpdOlj
 wD2fmcRfi+m3Ok0C6AeoDHXGA+j7GoKCisoPj9UwkBjEa+zvpqP+CO2Q+XOcWlnPfaIO8fjQyi9
 fI37u79Ip7uc0kmiaD/IorOKkRvZv/WcC4KGPzAH3bnUL3CU0+F+HobvFZ5wB3niecXcVQn9TjL
 xhd0WK
X-Received: by 2002:a5d:5c0c:0:b0:43d:21a:9a44 with SMTP id
 ffacd0b85a97d-43d2124da5dmr19069936f8f.23.1775413414233; 
 Sun, 05 Apr 2026 11:23:34 -0700 (PDT)
X-Received: by 2002:a5d:5c0c:0:b0:43d:21a:9a44 with SMTP id
 ffacd0b85a97d-43d2124da5dmr19069917f8f.23.1775413413802; 
 Sun, 05 Apr 2026 11:23:33 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c50a7sm35370969f8f.15.2026.04.05.11.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 11:23:33 -0700 (PDT)
Mime-Version: 1.0
Date: Sun, 05 Apr 2026 20:23:32 +0200
Message-Id: <DHLFJ2096PJM.325GEB1637R3Q@redhat.com>
Subject: Re: [PATCH] net/tap: avoid using netlink socket if closed
Cc: <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
User-Agent: aerc/0.21.0-127-g39acbf663345
References: <20260403192635.320320-1-stephen@networkplumber.org>
In-Reply-To: <20260403192635.320320-1-stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pufq4dfvMgd12DGJHjecabpPlrITB3dlh_itQp_t_6Q_1775413414
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

Stephen Hemminger, Apr 03, 2026 at 21:26:
> Coverity flagged that nlsk_fd could be negative when passed
> to tap_nl_set_flags() during device close.
>
> Coverity issue: 502576
> Fixes: b5d76639551e ("net/tap: replace ioctl with Netlink")
> Cc: stable@dpdk.org
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Thanks for the fix Stephen.

Reviewed-by: Robin Jarry <rjarry@redhat.com>

