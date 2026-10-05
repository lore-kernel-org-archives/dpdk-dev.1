Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9341DCA5FFE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:42:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C04340BA0;
	Mon,  5 Oct 2026 18:41:15 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 49AC940DD5
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:41:14 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3a7d7287703so1279097a91.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791218473;
 x=1791823273; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JEhfdJHQRcRNoWWtxMiEEt+mXe00ecKDUJIT9e838pY=;
 b=DnRselX9693GyHgHK3MiOCD72KHROm28yjVOewLEcTLDpMzDeG/GHODwimCRuoB5iA
 Wzq/Zy2ciWxEejVphkKuw0N958y1OT+XFCyWDt4Wz/PkdyZRkn6IWknes7CMswdww2h9
 gi+jUxCriMIAMK5i+YIIIKeakDkt/nxOr6pZhrOLjybm1mToxvB9P+J+xTmFfifGdglQ
 PV+WdrQWpd1Lnsq1Qz0FreSBRuKNwWbavSqWvYMK9WS4juBqToGqr4gMUbR+zCT+INxO
 toCDPw3GywFENIGNidoBEbwsBAJpfhpJnDW92v15p2OA62BmHmzPXFAarxi73CihT/b+
 JY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791218473; x=1791823273;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JEhfdJHQRcRNoWWtxMiEEt+mXe00ecKDUJIT9e838pY=;
 b=wmANrZ5RJK0SCNFpLZ+bVZ+f7mmT6HO08YfbPT/Vf5IKNQqtByqycknqbNTw+wAYJr
 /ENHsgmA47rsp09ECvNVpQnOJg6UeZI4U7LFXFBD8dE+FnkfPx2N8D2oxEDhWLZsUxYn
 LgYdUwaa7oCCkuLiOJWRUPOW0gPM8/ASBeEO49OocK/YlHohk7PiqX3wgUx3M4MyqXza
 FF5CN4890WN7jso283q+thsYXL7B8/0c/trets/uC6stVdS++MIx9HB7J6g3KvH2pQZ3
 KAfuNH1BHAb0V7ccQkFTyUKVB+e73ouEddl3PMLSLQwykaWG1VN3qKBXAfv9Foblm3o7
 1Jgg==
X-Gm-Message-State: AFq9FYIthKt2BOFP6CJY7hehVl7enFpV3uMfIDD/EfFRUsIGeuEXj+qs
 T0d6CnHFVqIqzwhfzdNKOjY8yz+/DbJAryqogYokDouwEJoIlFfKjJJ7pWqi5jyWMWG/LDMzO9F
 pJZBs
X-Gm-Gg: AYBFou3ghNLBVX+o3uha7g6gRw98r+Q5ULAAxbt8ULRz1Ol8IOHWr1QiPD5NYTeqFMb
 Fqs+D3YsZkeAM6kU8qvA4V/pqAGX7uc9k24+fenIrTqISbiY4pxnGPgQoUYn8cOmDGQL7N3BQv6
 Moqy42wboDTP1chD7JXOANw8oDoD1OryWrAwm8Glpp5DIlobanPmTge6gafp6Q253JHC2g0lFu0
 QBukshMxHqtDDPhfzpCkIeF0CYIdLckPjj2Mv5wDFkdNNhINd1Iqht08G0SyeZXor9PsvzK4leh
 hvgsPObdSY+CJ8l+likny9prcQxpAIEpBQrzttruuW0hMpmwQKfIoKlO4uBTO6PXpbidtZE7wr0
 5pUEM3Y+QILjtTar+T0dSupDHAYW/K8GOUl3I4CVh8E7iZ0625EFN3sFmoMQRuTieVIj73K1MDu
 NxkpGXwfnwj7vmlQh55pY1Mdfj+lB0/7vRT0pr810Rnz25TtrIs1oJNdtX5U+qLm8olj2F3UxJi
 GF2LP4lP4H+d8XrjlEcWW5j0QzhZ8BL4duDkMG+
X-Received: by 2002:a17:90b:4c4e:b0:3a0:7d60:450d with SMTP id
 98e67ed59e1d1-3a7873dfademr7027324a91.43.1791218473190; 
 Mon, 05 Oct 2026 09:41:13 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a853cb7cb3sm188973a91.11.2026.10.05.09.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:41:12 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:41:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v2] net/af_packet: add option to ignore outgoing packets
Message-ID: <20261005094111.211ed2b6@phoenix.local>
In-Reply-To: <20261005002809.1676723-1-frank@dressler.pro>
References: <20261004042255.1517316-1-frank@dressler.pro>
 <20261005002809.1676723-1-frank@dressler.pro>
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

On Mon,  5 Oct 2026 01:28:09 +0100
Frank Dressler <frank@dressler.pro> wrote:

>  
> +		if (ignore_outgoing) {
> +#if defined(PACKET_IGNORE_OUTGOING)
> +			rc = setsockopt(qsockfd, SOL_PACKET, PACKET_IGNORE_OUTGOING,
> +					&ignore_outgoing, sizeof(ignore_outgoing));
> +			if (rc == -1) {
> +				PMD_LOG_ERRNO(ERR,
> +					"%s: could not set PACKET_IGNORE_OUTGOING on AF_PACKET socket for %s",
> +					name, pair->value);
> +				goto error;
> +			}
> +#endif
> +		}
> +

Since PACKET_IGNORE_OUTGOING has been in kernel uapi since 4.19 the #ifdef here is not needed.
