Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E9BCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2859940E01;
	Tue, 29 Sep 2026 14:41:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1A8E34013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790685708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOJqP8nPZZRewbJYTYPOuqjIEW2lN1mXKiXlmx/GwvY=;
 b=J6F9KY7x363x18aKAsK9TC/vwGIbgnaHbyTGJqVXMYVq8IMUooMEXPf3AG7TNLmHncCK1x
 I+pfS7vj3q5KlrqwU2TuRfbW7dLf7Ad6LDXV/YKyFCkjGAQPOF3A8XvyGVETh5VY+6sObm
 8Gr1VpmTmto8cEfTdSP1A1leFZaEW3Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-hC_bi_4uOauE4h_HEMgvRA-1; Tue, 29 Sep 2026 08:41:47 -0400
X-MC-Unique: hC_bi_4uOauE4h_HEMgvRA-1
X-Mimecast-MFC-AGG-ID: hC_bi_4uOauE4h_HEMgvRA_1790685706
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a5f5969208so23123711fa.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 05:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685705; x=1791290505;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qOJqP8nPZZRewbJYTYPOuqjIEW2lN1mXKiXlmx/GwvY=;
 b=pdgLU+zNDlewv4x3/Zu9GDegYgmqgaH+6AwSPyQVElKyiOmt2dYWeJYTFjCYGWza/x
 zU0KypZ8bHczCLNBsf7JTDt344E+0fssHIixSDnb4hlajfYkwAD/QWAZngazxvFd1DkY
 iJt+fNM95igOEDprgiB5jbyEfwLtjyRJfbgsfJa34ww2cPIL+t88kbKab+LQGFeoqYQ7
 vErUvalWK/dzrJp+32sfwwn+Rp4IeVpbOetX3Uqvuf/asevRpY9Mf9URCT1NA2H+Dxyq
 wzkJrwPdOCpYJYOUkf1tDMta8PlmaJ6I0cMz8CiY/92lfG2wiT7O710mkuM0pQvka0u8
 3T8A==
X-Forwarded-Encrypted: i=1;
 AKwUvByDfl39hbVcz1wxkFgNxcUXeNL4juMYiyVHECB6Q/DEjgXP5cWpfQU/4+TimMpCnMWnRFY=@dpdk.org
X-Gm-Message-State: AFq9FYKeZy4hjP/DyPtNeClB/kgorcetdhkosp0gzaqmYtOGqUfBteuN
 QDzbWoIiubobqds/G/lAjRRrnptRQsUma6gwxa0xWZMTshGPagNa/ERdRyGqnuZNjlH/8ai5S7R
 s+YLGfR8ItXdGwCjGlFEp0HbRqUaaYl+lJwmFoxpnqqpQ39nPOYjIp23h/eGrlWjN8AMGBDNnOd
 odogl/b14kFnkCIswKDQ8=
X-Gm-Gg: AYBFou37iAIzXFuP049RDLSu9sFmiDAJcWLYNSn9REttN0HquLk44JnwdSGiKrPTZCZ
 2U0vjUFo8GUBQVXcr4qI4/oGzqoVQQh6MPNg8Z878Ee6Fk3hhGzgzLT48qzUqmR9DSPGNucEJU6
 wAmkR4vvrU7qoRXL6yLTH53nvPHmguQnP5xTZp0QMpDKtxqtsC2itHX328H8GUf4Moid7eC51hx
 Xk2Y89dpqbxRDIqBhPtJCuvCcgs5bLlnHPznI0PPHyBjI8QUgP8zIpvRAk=
X-Received: by 2002:a05:651c:2120:b0:3a6:6c19:a80f with SMTP id
 38308e7fff4ca-3a66c19b0ccmr16280821fa.11.1790685705545; 
 Tue, 29 Sep 2026 05:41:45 -0700 (PDT)
X-Received: by 2002:a05:651c:2120:b0:3a6:6c19:a80f with SMTP id
 38308e7fff4ca-3a66c19b0ccmr16279901fa.11.1790685700199; Tue, 29 Sep 2026
 05:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260928065849.126909-1-hemant.agrawal@nxp.com>
 <20260929104519.1770698-1-hemant.agrawal@nxp.com>
 <20260929104519.1770698-2-hemant.agrawal@nxp.com>
In-Reply-To: <20260929104519.1770698-2-hemant.agrawal@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 14:41:28 +0200
X-Gm-Features: AclHuK_47C62yS2IPlj7fpDV7BU4SSxPGfqRNXqOdecrOP36j_oIoqgAikwjGwU
Message-ID: <CAJFAV8xBzpUAnSvdr2NaGd36ZkDkv26yzLXzbNGGNXi024DfBg@mail.gmail.com>
Subject: Re: [PATCH v17 01/23] net/dpaa: fix device remove
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: stephen@networkplumber.org, thomas@monjalon.net, dev@dpdk.org, 
 stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V8fXAveFAx_IwnDmKF4qDx9uE4gTUb56ywt1FAD2RIs_1790685706
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 29 Sept 2026 at 12:45, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
>
> From: Gagandeep Singh <g.singh@nxp.com>
>
> Adds a check to not to close device if already closed.
>
> Fixes: 78ea4b4fcb52 ("bus/dpaa: improve cleanup")
> Cc: stable@dpdk.org
>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---
>  drivers/net/dpaa/dpaa_ethdev.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
> index 1aaf97f175..7dcd67fb81 100644
> --- a/drivers/net/dpaa/dpaa_ethdev.c
> +++ b/drivers/net/dpaa/dpaa_ethdev.c
> @@ -2679,9 +2679,12 @@ rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
>         PMD_INIT_FUNC_TRACE();
>
>         eth_dev = rte_eth_dev_allocated(dpaa_dev->device.name);
> -       ret = dpaa_eth_dev_close(eth_dev);
> -       if (eth_dev->state !=  RTE_ETH_DEV_UNUSED) {
> -               dpaa_eth_dev_close(eth_dev);
> +       if (eth_dev && eth_dev->state != RTE_ETH_DEV_UNUSED) {

Checking the state looks wrong.

If this driver .remove op is called, it means a probing succeeded.
And if probing succeeded and a ethdev exists, it should be in attached state.

Now, in the hypothesis we end up here with an allocated "unused"
eth_dev, it smells like a leak from a probing failure.

I spotted one, but it does not seem related to the current patch.
https://github.com/DPDK/dpdk/blob/main/drivers/net/dpaa/dpaa_ethdev.c#L2614


-- 
David Marchand

