Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62097CD4F4A
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 22:26:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A4674021E;
	Tue, 19 May 2026 00:26:42 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 04EBD40041
 for <dev@dpdk.org>; Tue, 19 May 2026 00:26:41 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso1808156eec.0
 for <dev@dpdk.org>; Mon, 18 May 2026 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779143200;
 x=1779748000; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABvMCDA+HCC00Cdfzxs02tDwZFXbUN3Q3ODtt1o3fjE=;
 b=ypN42k4eUmtXensQKciNZSFr2FQ8yycnrvXzrPhZlt1e8XZxNB/L32jJbH4FjPjNNF
 oSmEHIGQFXzdfpcIRQWYlzaTE6F5iqZ11lYuRdhjwXlLDQ7qBsmjJSMpzHuCJaiMR9GQ
 T/EwlFEti8Qf3Xl2Vw3nzJyhjKc0rKxSzCH1GC81BA5IB1BIqf2HXvB3iCn3PylXSqN2
 OK3VojHfCicecVm+jkv75sTrD68SIcX5Ckx2kxVwnX5PewCVyXQOWteltnI+8DzChaaL
 vSOuzO03ox1++BDFY7MuJp/jXMmgHqpxVuy3T3ofKBJ6GneVu4ePgX3UWDDgW5v99jjR
 biSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143200; x=1779748000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ABvMCDA+HCC00Cdfzxs02tDwZFXbUN3Q3ODtt1o3fjE=;
 b=W7UI7M0rXmsSnATRvDAOB1pS1fyqLejxMx6VDlOcE6J01KuZPgUCPuUiS9DGM2BJZA
 EDEFcY9F7Y1VxCluFqtcJm161QAGwTlJ+OmLEPEvPWx1cObpOChjdPfh5wpVamQge1BN
 /EAkReNxEy4pZwAzNlZI/12sRbGUz2ZFbfCcYwA92a07110WtiI2bFj/IPzo4vvZktvR
 Ub2jv6IKtqnzJYhgd+KvW1RgGmteoEhr63lkhb4YDDOnUYtvYWWGcVyGV3EeQ0OI6Qay
 /BUVOzf2L6FdQQOfqr1wEI0Q/axt8gThJNPabo3BUSF4lOAwcWTNlDLi54cuQ1ZAWkA6
 Xumg==
X-Gm-Message-State: AOJu0Yx70sPH83fEcYAiIBz5maK5QeI3Fgr0ABW3dHSpXJGWJvneCpET
 9G89x0PdSLQYereBirLAuen0KWuJpQyjJKHIUQIDE8glAasJqsGXdJRnnxOwwPFgND4=
X-Gm-Gg: Acq92OE0Hhsx4HpNgMr+A74DZNCmT3ubaO9qHcpIIP/VgkpU0dQuygHpgxbtwattpJh
 CgZ7ZvBG9UWuTDK839/3lXTYON3rrjQaiaR0f8693MlOJurO7LkH4bfctxI8NLpAl8epN+owzwB
 b7E6SeO7++ySdlXLFFLbDc5GUwG6vaIVXYiVhxsu5WJ5U/2okkP+lf9oL5NGxuu9p853l55SY1g
 5OaCfXkfNS/cJKD1DHucDxWMJXUlASzdid9ggVEMWFGRjHdb+EZMCAd2vGK9iMwo+NBwDOSuQTk
 QsTywDTsMWIFX/Bf7xkFlIQF0SSkUnH2LUSvLLCK58zJm3ZKHqeeM+zD0d8lff/zEYgDM0de3FO
 uu/lZub5G+PZtRPQruepc8NXS0SbfbJ84owSwrcJlIZWlXNjWQDCVan/xqZdWvWbFIc0cG8OGJN
 vvNTUtfZlDvfuIoYPiLMTgksvMKqQ/yeHF/Ak=
X-Received: by 2002:a05:7300:e12a:b0:2be:ca4:e114 with SMTP id
 5a478bee46e88-30397981629mr5855097eec.9.1779143199952; 
 Mon, 18 May 2026 15:26:39 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcc458sm18094726eec.18.2026.05.18.15.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:26:39 -0700 (PDT)
Date: Mon, 18 May 2026 15:26:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v6] net/tap: use offsets provided by rte_net_get_ptype
Message-ID: <20260518152635.7f95aa18@phoenix.local>
In-Reply-To: <20260518205448.142884-2-rjarry@redhat.com>
References: <20260422133615.680318-2-rjarry@redhat.com>
 <20260518205448.142884-2-rjarry@redhat.com>
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

On Mon, 18 May 2026 22:54:49 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> Instead of guessing what are the proper header lengths, pass
> a rte_net_hdr_lens struct to rte_net_get_ptype and use it to get the
> proper header lengths/offsets in tap_verify_csum.
> 
> This allows supporting stacked VLAN/QinQ tags.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

Applied to next-net
