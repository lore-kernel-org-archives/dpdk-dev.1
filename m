Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AEBD2FED9
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEB0240F1A;
	Tue, 27 Jan 2026 19:57:56 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id D662940E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:57:54 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so3621760f8f.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769540274;
 x=1770145074; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyPBnBomG3Cq0vx6nrYh3txFo9mqyhKl2/Vdsh/zB5Q=;
 b=UxmDIH8bGzUG2MxSsy0yiInZrPNgGnPh5E8mhuxwjjoNdqz5wfu//86r2sp6hs0SIe
 TpcbmRd38WZUKUGO76Ai2w0JzhfkTgtRbcwg/k5rYpuML7cPNQSiswtjFBk95H7+oEOj
 PgiE/M/9c7SN8KofKAhB5Dpj9y2uevL0ixKq0L4H5rCDLeYHntI/0KRiuzzgToRFrkDC
 Me3Fe1ozEQ1W2qb5lfmR0VO4AOu7Rno+Ym4bTUpZdNmSOOWdyO+hHD2gqp+xQ30+8ib8
 5zJpyaH3Sz5vGkL9P0YiVjox1JOXBCERZQoPU9VMsSpM4BFHXSVLjeVZXT9Z6VBT42oZ
 NB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540274; x=1770145074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nyPBnBomG3Cq0vx6nrYh3txFo9mqyhKl2/Vdsh/zB5Q=;
 b=lH6mj+ahyLb1pxfMQjPW0+H/jl8BUT968WWhJX4g6yG4pyAACPH6y8KsNGqAFJ6JtS
 qEa2cF97Ie1IwJsxH3qKW8sLRLT1iWCm5ZeINEdGieuh+dZ4wPcc0365jTucvNF/v770
 pV1STLui/MwI+CjXHNflm1mmCLv8o1Auk1yX9OEfT6bC/85163obkuD3OTMii4gotXhS
 33Q4sU/rMb039K42F+WLQ8WxzpC+SWOAOM0atYLQ1pq/0QHBXf3Pi+iWu54/knrLHMb8
 /18JRrMm+aYTXge4WjcWBLwZtuC+ZBWG98Yky2WiZhvly9l4b+Ijk6+V2RlZ693j2DgF
 rZ6w==
X-Gm-Message-State: AOJu0YzhZYZhRS9UckeQfirGJdT7leDti2LYrfyX3kYQHh+UcBXTotVU
 TPpF9UfHioDqkJiARqofwiwQ8vvPxeZuRWYahHUBgiK3QoWz2DPJfVdNKxl/3fU0oeWYO874ElY
 UnWQ/
X-Gm-Gg: AZuq6aLqZK2GSe7zyM4I+BrF31GdvZ0QtiC7hahqGXq21DK0w774Hr8s+AZUQT7XaS7
 3b9AOQNy97AM3sszQ8+GcaaHXFKk5bwryE26epHuaFRhCwDEAvEc8KuqSA8phN+1muN2ANZ50P6
 zgP+Hz1Ns6kBKhvb2/+8Lnnwlq3Mt2PphuxBXtjb5BK+Ue9Ui2XoM8H2LqqNTYrH+HsZ6wsusXv
 inuw0b5T6v74TXOJ3CTfo5sc9+hzhTnpFPiRI08bH+bo2Gc+1CTAr/5Me49De44XWG+UT25m28T
 mndq7fjkgYwjXsc2MY+Bj8XPp0MG5nJzveB83CIAkuYb40EWLb9hB0Frm7M6steHatthhLv8AAn
 AhGtIjwhWki10828vVuGN06m7xzdLADs3B7pJBnJJT8ZZo6a3CdpST4jkgodxf8fjmG9stT1OZg
 gDXQUF0B/vs4KFt/dslvRcQNz9AT12ZM8UtnfjjxgChsAEdvjbMR3c
X-Received: by 2002:a05:6000:2885:b0:432:86e1:bd34 with SMTP id
 ffacd0b85a97d-435dd1c0c54mr4243408f8f.39.1769540274411; 
 Tue, 27 Jan 2026 10:57:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee057sm969372f8f.15.2026.01.27.10.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:57:53 -0800 (PST)
Date: Tue, 27 Jan 2026 10:57:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 3/3] net/af_packet: software checksum and tx poll
 control
Message-ID: <20260127105749.2e2059a2@phoenix.local>
In-Reply-To: <20260127181355.98437-4-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-4-scott.k.mitch1@gmail.com>
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

On Tue, 27 Jan 2026 10:13:55 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
> 
> Add software checksum offload support and configurable TX poll
> behavior to improve flexibility and performance.
> 
> Implement af_packet_sw_cksum() helper to compute IPv4/UDP/TCP
> checksums in software when hardware offload is not available.
> This enables checksum offload on interfaces without HW support.

I don't think each driver should be doing its own checksum helper.
It should be done at application or through libraries.
All modern hardware does checksum offload, so if it doesn't probably
a driver bug.

> 
> Add txpollnotrdy devarg (default=true) to control whether poll()
> is called when the TX ring is not ready. This allows users to
> avoid blocking behavior if application threads are in asynchronous
> poll mode where blocking the thread has negative side effects and
> backpressure is applied via different means.
>

Needs to be a separate patch. Don't do two things in one patch.
Not sure if some variant of the existing configure thresholds
could be used for this.


> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
