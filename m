Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89D0CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:04:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4802F4064C;
	Tue, 26 Aug 2025 16:04:02 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 4EBBA402D4
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:04:01 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3c8fe6bd038so1198415f8f.1
 for <dev@dpdk.org>; Tue, 26 Aug 2025 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756217041;
 x=1756821841; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lvp7u5AUeLfitEsxT0yzArJa/CwMTLPmaUn7S154DME=;
 b=Tq/N/68JEPWbZ52h9DdGtknjARqkv5DT07+A43/yDSbz6lZwK83vNRabI9X4JZrZNv
 V2oLPYVOwFfCv2PvmDkaWoq3DdBtuvkA2VA3ev57D+RGAW2oPu0bs99JegqUhEKZDbpQ
 bB2E6DX/uT/IZex3QkQiwdaUiwf0sMAb3juDtDnKqSD8MHYNtgFsd3zPTmKdwH9CdoFU
 R9oA8ejT1UM8sMiDFP+DbE7xumZCQ2XBfQDuZiWDXISl3QnT+/QPRlpJW158RsIueTMh
 afTKqAGJA0bih0YsdoQV4t2orvtHP/J47Rm3uHGAwatS0yiRv7vcJxL9CKGIjVUY6meH
 hvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756217041; x=1756821841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lvp7u5AUeLfitEsxT0yzArJa/CwMTLPmaUn7S154DME=;
 b=GXc0oAhs9pzKaTNqfFGoNVkb4PgcGZISz2tRzZWqUdP/ajyg3XUlYxzrLwd5vlFcB/
 r61KY6L/j1Ti2IMHdnAVCSw5abEge9cvMAruDHUi5RYa3qehJNH7WOLqAFK5jA+UbYHe
 ZPbFAAZp69Zn7+bOp1U20lMzjM1nHVg+zoNrVVeWVY0fs/2uLu3PvlRUxyJvRipwE63J
 evUzIYQV/kz7H3lX2xm/xLt4c1QYniWGxOPmul3eu8wtbGFSA/l7lmLFbhimN6ir3ekm
 79PR2OmKqAeIYZ3DFDWP30W8XQy1JYypuYaGTtWLunWUtA9FL235lm6LhzExum/a0wRJ
 uAQQ==
X-Gm-Message-State: AOJu0Yw8DUxIl7xjqJChyMfhSEX7BLBYCOzIVfvafe5QpY8bY/iyBwPB
 zqDDCUWg6S5XqFFxJ2Zeuxgj7x8fIOn9tSocDESVTuRylI28GiSRWAi2T/4/GPPRzX0xsT+SfGj
 PCK8R
X-Gm-Gg: ASbGncvlkNLgqPREteh5oAEAv08xkiPa3Kpibr21xsdAEE2bpTdrOQhjpxQ0TghFJKx
 Pgi4f/jaKqIQcmf4TRvnD4wBH7R6SHB2+e7iKgimv2cLjLUikKWz3orvc7c1ov+a/cCzRQ/K3/C
 OFyeIUsG7AKGkQwqQZVcLAtPFWRXuBmrjyPp1QyMdC+sW5mI0VM62csCeyAUFfGS7oD1DeAQRfb
 EuRqGKcdFMIgHxzhW70orrnFn8d5hvrN5YIkDAu7KFnUwGvEYO5JDK8WpSsg3HyS+l0K1QAGZyA
 BT1O0zThMEPwy/P0H9oLwNCLOhDTzmSebbp+unYm+VBUvuuCW5Ey1T2wXD7c3q99NbF6GkKVcd8
 MTTqvYHc81rF/22UbhSoEewBbi2kTQZnTT0Ldi2AzqXpS0N4HBz8ijpPqFHPcCfefw3Z8LX0Ixh
 A=
X-Google-Smtp-Source: AGHT+IGe6ZXe7OnRc+gz/YzOLcDABp/XCRU/4qFowtIVhV9b1fv7FRE+dr4FP4N6Vd2iuC1LO6a25w==
X-Received: by 2002:a05:6000:4383:b0:3c5:9e0f:7607 with SMTP id
 ffacd0b85a97d-3c5dc734286mr11621969f8f.33.1756217040679; 
 Tue, 26 Aug 2025 07:04:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4b9e1fsm17820621f8f.14.2025.08.26.07.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:04:00 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:03:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: Re: [PATCH] net/zxdh: replace zero length array
Message-ID: <20250826070356.14da72da@hermes.local>
In-Reply-To: <20250821152536.5934-1-stephen@networkplumber.org>
References: <20250821152536.5934-1-stephen@networkplumber.org>
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

On Thu, 21 Aug 2025 08:25:35 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Zero length arrays are a GNU C extension, the better way to
> get the same effect is to use ISO C99 flexible array.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Queued to next-net
