Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F30DCC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 16:23:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACC58402E7;
	Fri, 16 Oct 2026 18:23:51 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id BA1524026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 18:23:50 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e977109392so56035ad.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792167830;
 x=1792772630; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mgyo3V2yXEtnrB69gM9NLIho4E4kXeTxzUG+OgJGEjE=;
 b=QcIN7/4vBweTFt9NmUj1dAMEaV86hW6sa8eLrfAhs446WLLKsYcyayl50O7L6oAP6S
 DAMOGjSkRZm+SgUU4aJsUMRCRd9TEWKWmU1Gq035f49MPrjzqmgW//wpxJDy8UzmPIjI
 wXSaeR0CK6dGLtKgDFp6ikQLYmroxW5AOjg77d72whsAlYwhg4WBfJfiunT8/UP/HnvF
 Q1agyCMpjprVfysd+uiaR1IplUBhzC+Un5JuzqONAwWtpeJuahNsaG9iUhxDCs0XUewM
 6GEiJ2mdCV5JCIbAp0MkoW0JN3NyqUH/+vx89kjOv+8xSKnhiDxMTezPPf2jexzeTfVq
 1T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167830; x=1792772630;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mgyo3V2yXEtnrB69gM9NLIho4E4kXeTxzUG+OgJGEjE=;
 b=17716spGA7mCQsmmOykHIbqxsJ7CXC+A8giC6Bufy7C9HXU43DgR9E6d/4BzMEnDau
 b+ypMprf5yPUNG7VDHOozbPdiOqEtLml0ieM2p7ohnc8BhJ8HSbPTpWkmaj6WLxmGL2Z
 xpXVY1W4NMVFc88udxoUZkyzwtinROcUwImaksThL0dOJCOXqH0bkpmsZRzLVonWLIhh
 x9OgmgRb9xVy/ly/qMZE3QjVWvVQ7VaCUTU+GYuvDEQeamacfkz22TEbGxKYwU0MkEx4
 4/HjxKwVUZe3T/bcAtFM7k9q7+pwoLCN0XAGCbnIEJIDJ1RVHqUVw2T3xj1+B7SetsmF
 m45w==
X-Gm-Message-State: AFq9FYLTmLUahPoCyZnVK0dPmFh8CghUZlu/HEQ46ZQzA3eVcIDiaBKT
 caAVWPjqfIJrXBRICNMNdhptXSbYo4jSxASNAkWN1LBC7P8aqwcHQSbYFTIn4ZCkKdE=
X-Gm-Gg: AYBFou0Xi4QJTQcU80AaxQRMwn0TtTFT3II7OI3uV30A26GtkVfSoRkE7rt4cT4GPsE
 0C5ddDAGtfToU3lpsIdZssNoOzk++a80rsXXMMZony7rr9PJYaczRU8t1JFBky5rX32wwQ5p2Jj
 gwsGar1qng8hh3gudx8/dyPqmU1zCgGICZ8VHDSQryrB541bSDRz8K9qrgPbxa2hRjhMQQEhJaf
 YxjyWERw9CGgnztNdbepjNRiHFVWxBb9n5ae/MJdzFMiMXi0Cqr78vegfWkOQT2YB6Z2+w/0NNB
 z8jNrFJT+SiPcfN8KLM1bPmfgl8IjgL8AkmZoucrIZkdLtLCc58nRRMK6kxQ7pCpD/wTVVrQt5v
 4DWCK+uSKwg+NbtGHb53HGQuzCeTDCKobg5wf4zggzCV/pTVK+/f5vNRmCbUIiA3Pv7DwXFye8i
 k5Nsa9Yw+qkqEFkM52Wmi+5vEOaynXJG7tVAyb/Wn9DzfxvzfevTni9mrPODcwDEQbyewd5UIB+
 K/62YttDTPZytka6qdwG1L6Va7qOx6aC4RYV8Bd
X-Received: by 2002:a17:903:2c8b:b0:2e9:5c55:c46a with SMTP id
 d9443c01a7336-2e9a6834a18mr4836615ad.7.1792167829667; 
 Fri, 16 Oct 2026 09:23:49 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e804ef4sm12420095ad.18.2026.10.16.09.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:23:49 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:23:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, joshwash@google.com
Subject: Re: [PATCH v3 00/10] net/gve: fix DQO Tx queue stalls
Message-ID: <20261016092347.480e6453@phoenix.local>
In-Reply-To: <cover.1792129992.git.tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <cover.1792129992.git.tathagat.dpdk@gmail.com>
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

On Fri, 16 Oct 2026 06:26:37 +0000
Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:

> This series fixes several ways the gve DQO RDA Tx path can stall or
> post invalid descriptors: completion handling bugs (1-2), a report
> event interval that can starve the ring (3), a stray TSO context
> descriptor when completion tags run out (4), a missing cacheline
> margin (5), invalid packets blocking the burst (6-8), and missing
> device length checks (9-10).


Looks good, but does not apply to main now.

Also need a ack from GVE maintainer across all of the patches
