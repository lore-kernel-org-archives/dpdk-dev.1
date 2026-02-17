Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE73E909B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:41:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A84EA40653;
	Tue, 17 Feb 2026 15:41:01 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 1FE1B4064C
 for <dev@dpdk.org>; Tue, 17 Feb 2026 15:41:00 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so37499715e9.0
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771339260;
 x=1771944060; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rgSh3ADM8GeQoapncYBpH0AEfZ9ZZ9K0idoKj7JdRt4=;
 b=ENTPRiXSpqSUXgp3cMBntgFD6+l8gldvznl/x87U0blZeGKn9Qr/kNIXsISHPx0cgn
 GFwhTd+UisKfzLAIEw1R3hj/Ei00dcpL0P2LGQLUQ+v4HGnLaRbNyy5ePfjv+FtFIsGc
 bi7w149T6lUEGWkx2ij/c7YPhTQL2Pfatrowdlj0/GyRV19K2bS2WHu5ucku4rqyuRZv
 jRRVYvf0gE72EHYkmwj9RP0sKBtL6/GnKVAWpCZ4cFt9L/8H/fupLAQ6eiCNFL0VXrdS
 gbd4j+zaztEJIBHpravssE5uAavxL+vIIEtnsbv4Iv5fFRKpUJ3wCJNqRFduZwdEu2Zc
 H9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771339260; x=1771944060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rgSh3ADM8GeQoapncYBpH0AEfZ9ZZ9K0idoKj7JdRt4=;
 b=THHKmED2hwCik5Vn4FP/6rpNANm7rizn63HspnkIscxfWp0I2g9+5QkwUnj404AMaI
 178bmdJXzKDXaaf+EgN/XPXmFrjJUJSrEW83vsOvO5/fOT+ObXT6f+wUOXI3+I2ON9M1
 oad5tb2obFEmVA2zEEFBGDzuxygxFAJzz/QZinswj7aG4Dwxa4vSpWlcKMfH0WBR4l2N
 n133HPRTz3+9VIQx+FXNPyQJtepX405PQul+c+JTmviMZHjL4IySEGiB1+KeHyWmqAxD
 XFQchblQhf2aTVVM4rzsEyeN8y5Acz6d9CnfS9JMdeN2Dn4+/ghB9pnV2k2xBHh8d7ko
 ciNA==
X-Gm-Message-State: AOJu0Yx5qY0+5tkYg/js52wwtxqWUzhitD1lBsWUfOOgCmdvc5JrpGHo
 KEGmerQDHt7RW6MEqov2aiymESOQZ1F3eqQqrjF7xi51nwPGmP3CKkgf+WNVhTYn5h0G1uGu1hs
 WA0sa
X-Gm-Gg: AZuq6aIQdwt+cpG9ajiYRKqzPdqMrliPQg1UZVzxe2t3UhbG89BLs86Ep2+EwEFNbLy
 WqTyDYf7cbCUEm5LxtvcosVfK49G5YyXuw4iMSI4+lwFE61gVXsWL5Cw5EuypdVG//GpkJh4c33
 x+aRQNfiBC8D7wIIfr3aX7/fBWOVDvAp49l7iDWohr1V8WrNTFuZ+AdtJPBVt4HyeGetOxIhgtA
 O3Z3XATGw/k+nGwqpqjI1NTLAr4zll3v9myphEvDSghu+5dZ9iSfTV1RXTTSaubjm6RjuW6Yh6B
 yefXKv3KXyFm/FOU/C3fEz/zwFpW0MhoOgeg2QgsjToyDaZ7sIYvUAgplflx6VwyH9/nnS13ZkJ
 3L/LlHIzOQ1TAESbIbo0l8YQrzgm+cgPgMO8e7qaUWmzuhB7z09iPk/RTh6eiMPxgrBcgQ5PVZV
 xdmIBHPUXzgY6V4pG6hQwpT80/Ggevr+76Yv0PqbR+TWbiimOoHOd9kp3+HAgKi0Hs
X-Received: by 2002:a05:600c:8b4c:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-4837106152cmr234714975e9.16.1771339259628; 
 Tue, 17 Feb 2026 06:40:59 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abd793sm34596368f8f.25.2026.02.17.06.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 06:40:59 -0800 (PST)
Date: Tue, 17 Feb 2026 06:40:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 2/6] ethdev: add RSS type helper APIs
Message-ID: <20260217064055.7bdec42c@phoenix.local>
In-Reply-To: <20260202113659.24052-3-sismis@dyna-nic.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <20260202113659.24052-3-sismis@dyna-nic.com>
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

On Mon,  2 Feb 2026 12:36:54 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> Add a global RSS type string table and helper functions to convert
> between RSS type names and values.
> Add unit tests for RSS type helper.
> 
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
> ---

Since the only usage of this in flow parser, marking this as deferred.
When flow parser is reworked, this can be reconsidered.
Thomas had point that ideally table of strings could be auto generated
so that new flow types could be added in one place.
