Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4C2C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:47:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EF2E40B8C;
	Wed,  9 Jul 2025 19:47:20 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 9DAFB40A7D
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:47:18 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6fad8b4c927so1887496d6.0
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1752083238;
 x=1752688038; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=akxYlWe6svM2Uw5rTd3nqHAP2hkGB8aO2fAqjMgOsYU=;
 b=TmGNVmjC1wHspGjONQz4WrjyVaF4Q3qSqfDQrl08gxyECaXH4hVtYf/90i2VAuAOoo
 73qwA0aYHYkgF0DaH7vcmqE0S0G3i8oxLzmVCK4d98H201ten5EtyiUpml2sBh6d7fbU
 k3d0pAI5A4/6eIDgZozs8EIZ7HnJO81ERyFGhP2lK9B+wEfWpJMAQI9hFDC7JgOKRzmT
 qqqFMNeTPiLmtwkeNnoc3XtBDxm+mWhCicAUtcYkIdSZhmHHwz+icVkc6xZB4pGbtooU
 hD3yqX9cKAU3ALcJfVK4eutXxeSx30ByZr2trD8SnyGh0s4igboLIXNS5GwhXuk3O+hY
 kD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752083238; x=1752688038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=akxYlWe6svM2Uw5rTd3nqHAP2hkGB8aO2fAqjMgOsYU=;
 b=qhda6TZy1WsNO+An4G5J5BwydMPUZNCnQYiB/8R1yxKqMdb8wGXuMiy+8my50lWjyp
 ZpgNd5VP/EFqIngrbJqWq1x9pYZ1vu9khGEDs96D0WiOFtzA0LMScPIDockPVNWMAQsQ
 O24xau8EqXVZKCSzHTTgTuV6OFtSv6o+XTj3TIqkd2w3oUqDKkouS/H0cMB7o5ysfFfP
 ctrn7r6rvlPy0o19P7mKWam2LRaJDev5UWAgdnlMWXyoetOg2gnlqQbWoO50T9z9Wt8V
 ejmEl0gxZpMx3paCcSD5IXIkJU03H1oBdykRT09yAG8OBRZOz98Ig50mTtKt7xHmqJp5
 IgBw==
X-Gm-Message-State: AOJu0YxOlahhFwmfBKxlQ3nNfjbdBJ9DM+sIjYQYRvOncrGM7W0h7UoX
 a0SYVbQuZz/eVcEoljD2t4omatpLDDfiIp6qkYQfoK5M1LvN0ICQqrUNEJJc9K5ErzOUqKO3RVQ
 9O5W3ik2lGkIfSuJdP1lMFuCBqwbl2UvUoadqZGDBNfC6enSrirHX
X-Gm-Gg: ASbGnct01Ln4ErLqPmM7+K5magR+R5R37s/nx+VpwMg8AcxClpph3JPGx6meK6zc2Ap
 koQV74vgjz55ot8S3rpevTjuPffaWnHwUTsVJBWSL7S9JjJolXmQondsV0UnObqx1512d77BqzZ
 066kI6tHlX7rQpTSo0zM/BA7D+cHYIPJX0xftMSvaQApihc6zyRfJg+gfOGwapnOkHSlvWMrJje
 mI4
X-Google-Smtp-Source: AGHT+IEfwrG+RYfwBztFy8xQMJvRrLCsR5JrYfz7IYbMPM8e9zyHynF67O2hkCuwOoCDMyKuyhQZtX/0roe4vrh5coQ=
X-Received: by 2002:ad4:5aa9:0:b0:6fb:6114:1034 with SMTP id
 6a1803df08f44-70495068decmr14660346d6.39.1752083237877; Wed, 09 Jul 2025
 10:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250709173611.6390-1-stephen@networkplumber.org>
 <20250709173611.6390-2-stephen@networkplumber.org>
In-Reply-To: <20250709173611.6390-2-stephen@networkplumber.org>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 9 Jul 2025 22:47:05 +0500
X-Gm-Features: Ac12FXwiSLrdLbyKAfDAyfqE7jKCJCQZCjZpF3ypB52VoK52-gkQ4cIvchiEBmg
Message-ID: <CA++2-x43vKdvZ0KnJtzAPtYdOcP9JsMQYc1QJVmBC3fFjnQ=TQ@mail.gmail.com>
Subject: Re: [RFC v2 01/12] ethdev: allow start/stop from secondary process
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Content-Type: multipart/alternative; boundary="00000000000002e0e5063982ab31"
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

--00000000000002e0e5063982ab31
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does that means that the RSS of the secondary application can be also
applied to the primary application, or in case of multiple instances on the
same interface ?

Best,
Khadem

On Wed, Jul 9, 2025, 22:36 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> Before this patch if secondary process called start/stop
> it would only impact the secondary process, the ethdev on the
> primary process was not started.
>
> With this patch, when start/stop is called from secondary,
> it calls the primary and does the operation there. The design
> is generic, and we can later add queue and other operations
> as needed.
>
> Bugzilla ID: 73
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ethdev/ethdev_driver.c  | 11 ++++-
>  lib/ethdev/ethdev_private.c | 93 +++++++++++++++++++++++++++++++++++++
>  lib/ethdev/ethdev_private.h | 26 +++++++++++
>  lib/ethdev/rte_ethdev.c     | 84 +++++++++++++++++++--------------
>  4 files changed, 177 insertions(+), 37 deletions(-)
>
> diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
> index ec0c1e1176..66ba7dafc9 100644
> --- a/lib/ethdev/ethdev_driver.c
> +++ b/lib/ethdev/ethdev_driver.c
> @@ -114,6 +114,14 @@ rte_eth_dev_allocate(const char *name)
>                 goto unlock;
>         }
>
> +       if (eth_dev_shared_data->allocated_ports =3D=3D 0 &&
> +           rte_mp_action_register(ETHDEV_MP, ethdev_server) &&
> +           rte_errno !=3D ENOTSUP) {
> +               RTE_ETHDEV_LOG_LINE(ERR,
> +                        "Could not start %s service", ETHDEV_MP);
> +               goto unlock;
> +       }
> +
>         eth_dev =3D eth_dev_get(port_id);
>         eth_dev->flow_fp_ops =3D &rte_flow_fp_default_ops;
>         strlcpy(eth_dev->data->name, name, sizeof(eth_dev->data->name));
> @@ -282,7 +290,8 @@ rte_eth_dev_release_port(struct rte_eth_dev *eth_dev)
>                 memset(eth_dev->data, 0, sizeof(struct rte_eth_dev_data))=
;
>                 eth_dev->data =3D NULL;
>
> -               eth_dev_shared_data->allocated_ports--;
> +               if (--eth_dev_shared_data->allocated_ports =3D=3D 0)
> +                       rte_mp_action_unregister(ETHDEV_MP);
>                 eth_dev_shared_data_release();
>         }
>
> diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
> index 285d377d91..184cf33f99 100644
> --- a/lib/ethdev/ethdev_private.c
> +++ b/lib/ethdev/ethdev_private.c
> @@ -2,6 +2,8 @@
>   * Copyright(c) 2018 Ga=C3=ABtan Rivet
>   */
>
> +#include <assert.h>
> +
>  #include <eal_export.h>
>  #include <rte_debug.h>
>
> @@ -477,3 +479,94 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev,
> uint16_t nb_queues)
>         dev->data->nb_tx_queues =3D nb_queues;
>         return 0;
>  }
> +
> +static int
> +ethdev_handle_request(const struct ethdev_mp_request *req)
> +{
> +       switch (req->operation) {
> +       case ETH_REQ_START:
> +               return rte_eth_dev_start(req->port_id);
> +
> +       case ETH_REQ_STOP:
> +               return rte_eth_dev_stop(req->port_id);
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static_assert(sizeof(struct ethdev_mp_request) <=3D RTE_MP_MAX_PARAM_LEN=
,
> +       "ethdev MP request bigger than available param space");
> +
> +static_assert(sizeof(struct ethdev_mp_response) <=3D RTE_MP_MAX_PARAM_LE=
N,
> +       "ethdev MP response bigger than available param space");
> +
> +int
> +ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer)
> +{
> +       const struct ethdev_mp_request *req
> +               =3D (const struct ethdev_mp_request *)mp_msg->param;
> +
> +       struct rte_mp_msg mp_resp =3D {
> +               .name =3D ETHDEV_MP,
> +       };
> +       struct ethdev_mp_response *resp;
> +
> +       resp =3D (struct ethdev_mp_response *)mp_resp.param;
> +       mp_resp.len_param =3D sizeof(*resp);
> +       resp->res_op =3D req->operation;
> +
> +       /* recv client requests */
> +       if (mp_msg->len_param !=3D sizeof(*req))
> +               resp->err_value =3D -EINVAL;
> +       else
> +               resp->err_value =3D ethdev_handle_request(req);
> +
> +       return rte_mp_reply(&mp_resp, peer);
> +}
> +
> +int
> +ethdev_request(uint16_t port_id, enum ethdev_mp_operation operation,
> +              const void *buf, size_t buf_len)
> +{
> +       struct rte_mp_msg mp_req =3D { };
> +       struct rte_mp_reply mp_reply;
> +       struct ethdev_mp_request *req;
> +       struct timespec ts =3D {.tv_sec =3D 5, .tv_nsec =3D 0};
> +       int ret;
> +
> +       if (sizeof(*req) + buf_len > RTE_MP_MAX_PARAM_LEN) {
> +               RTE_ETHDEV_LOG_LINE(ERR,
> +                                   "request %u port %u invalid len %zu",
> +                                   operation, port_id, buf_len);
> +               return -EINVAL;
> +       }
> +
> +       strlcpy(mp_req.name, ETHDEV_MP, RTE_MP_MAX_NAME_LEN);
> +       mp_req.len_param =3D sizeof(*req) + buf_len;
> +
> +       req =3D (struct ethdev_mp_request *)mp_req.param;
> +       req->operation =3D operation;
> +       req->port_id =3D port_id;
> +
> +       if (buf_len > 0)
> +               memcpy(req->config, buf, buf_len);
> +
> +       ret =3D rte_mp_request_sync(&mp_req, &mp_reply, &ts);
> +       if (ret =3D=3D 0) {
> +               const struct rte_mp_msg *mp_rep =3D &mp_reply.msgs[0];
> +               const struct ethdev_mp_response *resp
> +                       =3D (const struct ethdev_mp_response *)mp_rep->pa=
ram;
> +
> +               if (resp->err_value =3D=3D 0)
> +                       ret =3D 0;
> +               else
> +                       rte_errno =3D -resp->err_value;
> +               free(mp_reply.msgs);
> +       }
> +
> +       if (ret < 0)
> +               RTE_ETHDEV_LOG_LINE(ERR,
> +                      "port %up ethdev op %u failed", port_id, operation=
);
> +       return ret;
> +}
> diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
> index b07b1b4c42..f58f161871 100644
> --- a/lib/ethdev/ethdev_private.h
> +++ b/lib/ethdev/ethdev_private.h
> @@ -79,4 +79,30 @@ void eth_dev_txq_release(struct rte_eth_dev *dev,
> uint16_t qid);
>  int eth_dev_rx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues)=
;
>  int eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues)=
;
>
> +/* Used to allow start/stop from secondary */
> +#define ETHDEV_MP      "mp_ethdev"
> +
> +enum ethdev_mp_operation {
> +       ETH_REQ_START,
> +       ETH_REQ_STOP,
> +};
> +
> +struct ethdev_mp_request {
> +       uint16_t operation;
> +       uint16_t port_id;
> +       uint32_t reserved;
> +
> +       uint8_t config[]; /* operation specific */
> +};
> +
> +struct ethdev_mp_response {
> +       uint16_t res_op;
> +       uint16_t port_id;
> +       int32_t err_value;
> +};
> +
> +int ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer);
> +int ethdev_request(uint16_t port_id, enum ethdev_mp_operation op,
> +                  const void *buf, size_t buf_len);
> +
>  #endif /* _ETH_PRIVATE_H_ */
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index dd7c00bc94..41363af2c3 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -1800,54 +1800,61 @@ rte_eth_dev_start(uint16_t port_id)
>
>         if (dev->data->dev_configured =3D=3D 0) {
>                 RTE_ETHDEV_LOG_LINE(INFO,
> -                       "Device with port_id=3D%"PRIu16" is not configure=
d.",
> -                       port_id);
> +                                   "Device with port_id=3D%"PRIu16" is n=
ot
> configured.",
> +                                   port_id);
>                 return -EINVAL;
>         }
>
>         if (dev->data->dev_started !=3D 0) {
>                 RTE_ETHDEV_LOG_LINE(INFO,
> -                       "Device with port_id=3D%"PRIu16" already started"=
,
> -                       port_id);
> +                                   "Device with port_id=3D%"PRIu16" alre=
ady
> started",
> +                                   port_id);
>                 return 0;
>         }
>
> -       ret =3D rte_eth_dev_info_get(port_id, &dev_info);
> -       if (ret !=3D 0)
> -               return ret;
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +               ret =3D rte_eth_dev_info_get(port_id, &dev_info);
> +               if (ret !=3D 0)
> +                       return ret;
>
> -       restore_flags =3D rte_eth_get_restore_flags(dev, RTE_ETH_START);
> +               restore_flags =3D rte_eth_get_restore_flags(dev,
> RTE_ETH_START);
>
> -       /* Lets restore MAC now if device does not support live change */
> -       if ((*dev_info.dev_flags & RTE_ETH_DEV_NOLIVE_MAC_ADDR) &&
> -           (restore_flags & RTE_ETH_RESTORE_MAC_ADDR))
> -               eth_dev_mac_restore(dev, &dev_info);
> +               /* Restore MAC now if device does not support live change
> */
> +               if ((*dev_info.dev_flags & RTE_ETH_DEV_NOLIVE_MAC_ADDR) &=
&
> +                   (restore_flags & RTE_ETH_RESTORE_MAC_ADDR))
> +                       eth_dev_mac_restore(dev, &dev_info);
>
> -       diag =3D dev->dev_ops->dev_start(dev);
> -       if (diag =3D=3D 0)
> -               dev->data->dev_started =3D 1;
> -       else
> -               return eth_err(port_id, diag);
> +               diag =3D dev->dev_ops->dev_start(dev);
> +               if (diag =3D=3D 0)
> +                       dev->data->dev_started =3D 1;
> +               else
> +                       return eth_err(port_id, diag);
>
> -       ret =3D eth_dev_config_restore(dev, &dev_info, restore_flags,
> port_id);
> -       if (ret !=3D 0) {
> -               RTE_ETHDEV_LOG_LINE(ERR,
> -                       "Error during restoring configuration for device
> (port %u): %s",
> -                       port_id, rte_strerror(-ret));
> -               ret_stop =3D rte_eth_dev_stop(port_id);
> -               if (ret_stop !=3D 0) {
> +               ret =3D eth_dev_config_restore(dev, &dev_info,
> restore_flags, port_id);
> +               if (ret !=3D 0) {
>                         RTE_ETHDEV_LOG_LINE(ERR,
> -                               "Failed to stop device (port %u): %s",
> -                               port_id, rte_strerror(-ret_stop));
> -               }
> +                               "Error during restoring configuration for
> device (port %u): %s",
> +                                port_id, rte_strerror(-ret));
> +                       ret_stop =3D rte_eth_dev_stop(port_id);
> +                       if (ret_stop !=3D 0) {
> +                               RTE_ETHDEV_LOG_LINE(ERR,
> +                                       "Failed to stop device (port %u):
> %s",
> +                                        port_id, rte_strerror(-ret_stop)=
);
> +                       }
>
> -               return ret;
> -       }
> +                       return ret;
> +               }
>
> -       if (dev->data->dev_conf.intr_conf.lsc =3D=3D 0) {
> -               if (dev->dev_ops->link_update =3D=3D NULL)
> -                       return -ENOTSUP;
> -               dev->dev_ops->link_update(dev, 0);
> +               if (dev->data->dev_conf.intr_conf.lsc =3D=3D 0) {
> +                       if (dev->dev_ops->link_update =3D=3D NULL)
> +                               return -ENOTSUP;
> +                       dev->dev_ops->link_update(dev, 0);
> +               }
> +       } else {
> +               /* in secondary, proxy to primary */
> +               ret =3D ethdev_request(port_id, ETH_REQ_START, NULL, 0);
> +               if (ret !=3D 0)
> +                       return ret;
>         }
>
>         /* expose selection of PMD fast-path functions */
> @@ -1880,9 +1887,14 @@ rte_eth_dev_stop(uint16_t port_id)
>         /* point fast-path functions to dummy ones */
>         eth_dev_fp_ops_reset(rte_eth_fp_ops + port_id);
>
> -       ret =3D dev->dev_ops->dev_stop(dev);
> -       if (ret =3D=3D 0)
> -               dev->data->dev_started =3D 0;
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +               ret =3D dev->dev_ops->dev_stop(dev);
> +               if (ret =3D=3D 0)
> +                       dev->data->dev_started =3D 0;
> +       } else {
> +               ret =3D ethdev_request(port_id, ETH_REQ_STOP, NULL, 0);
> +       }
> +
>         rte_ethdev_trace_stop(port_id, ret);
>
>         return ret;
> --
> 2.47.2
>
>

--00000000000002e0e5063982ab31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPkRvZXMgdGhhdCBtZWFucyB0aGF0IHRoZSBSU1Mgb2YgdGhlIHNlY29u
ZGFyeSBhcHBsaWNhdGlvbiBjYW4gYmUgYWxzbyBhcHBsaWVkIHRvIHRoZSBwcmltYXJ5IGFwcGxp
Y2F0aW9uLCBvciBpbiBjYXNlIG9mIG11bHRpcGxlIGluc3RhbmNlcyBvbiB0aGUgc2FtZSBpbnRl
cmZhY2UgP8KgPGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+QmVzdCzC
oDwvZGl2PjxkaXYgZGlyPSJhdXRvIj5LaGFkZW08L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUgZ21haWxfcXVvdGVfY29udGFpbmVyIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0i
Z21haWxfYXR0ciI+T24gV2VkLCBKdWwgOSwgMjAyNSwgMjI6MzYgU3RlcGhlbiBIZW1taW5nZXIg
Jmx0OzxhIGhyZWY9Im1haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZyI+c3RlcGhlbkBu
ZXR3b3JrcGx1bWJlci5vcmc8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+QmVmb3JlIHRoaXMgcGF0Y2ggaWYgc2Vjb25k
YXJ5IHByb2Nlc3MgY2FsbGVkIHN0YXJ0L3N0b3A8YnI+DQppdCB3b3VsZCBvbmx5IGltcGFjdCB0
aGUgc2Vjb25kYXJ5IHByb2Nlc3MsIHRoZSBldGhkZXYgb24gdGhlPGJyPg0KcHJpbWFyeSBwcm9j
ZXNzIHdhcyBub3Qgc3RhcnRlZC48YnI+DQo8YnI+DQpXaXRoIHRoaXMgcGF0Y2gsIHdoZW4gc3Rh
cnQvc3RvcCBpcyBjYWxsZWQgZnJvbSBzZWNvbmRhcnksPGJyPg0KaXQgY2FsbHMgdGhlIHByaW1h
cnkgYW5kIGRvZXMgdGhlIG9wZXJhdGlvbiB0aGVyZS4gVGhlIGRlc2lnbjxicj4NCmlzIGdlbmVy
aWMsIGFuZCB3ZSBjYW4gbGF0ZXIgYWRkIHF1ZXVlIGFuZCBvdGhlciBvcGVyYXRpb25zPGJyPg0K
YXMgbmVlZGVkLjxicj4NCjxicj4NCkJ1Z3ppbGxhIElEOiA3Mzxicj4NCjxicj4NClNpZ25lZC1v
ZmYtYnk6IFN0ZXBoZW4gSGVtbWluZ2VyICZsdDs8YSBocmVmPSJtYWlsdG86c3RlcGhlbkBuZXR3
b3JrcGx1bWJlci5vcmciIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIiPnN0ZXBoZW5A
bmV0d29ya3BsdW1iZXIub3JnPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGxpYi9ldGhkZXYvZXRo
ZGV2X2RyaXZlci5jwqAgfCAxMSArKysrLTxicj4NCsKgbGliL2V0aGRldi9ldGhkZXZfcHJpdmF0
ZS5jIHwgOTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj4NCsKgbGli
L2V0aGRldi9ldGhkZXZfcHJpdmF0ZS5oIHwgMjYgKysrKysrKysrKys8YnI+DQrCoGxpYi9ldGhk
ZXYvcnRlX2V0aGRldi5jwqAgwqAgwqB8IDg0ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLTxicj4NCsKgNCBmaWxlcyBjaGFuZ2VkLCAxNzcgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRp
b25zKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2xpYi9ldGhkZXYvZXRoZGV2X2RyaXZlci5j
IGIvbGliL2V0aGRldi9ldGhkZXZfZHJpdmVyLmM8YnI+DQppbmRleCBlYzBjMWUxMTc2Li42NmJh
N2RhZmM5IDEwMDY0NDxicj4NCi0tLSBhL2xpYi9ldGhkZXYvZXRoZGV2X2RyaXZlci5jPGJyPg0K
KysrIGIvbGliL2V0aGRldi9ldGhkZXZfZHJpdmVyLmM8YnI+DQpAQCAtMTE0LDYgKzExNCwxNCBA
QCBydGVfZXRoX2Rldl9hbGxvY2F0ZShjb25zdCBjaGFyICpuYW1lKTxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGdvdG8gdW5sb2NrOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQor
wqAgwqAgwqAgwqBpZiAoZXRoX2Rldl9zaGFyZWRfZGF0YS0mZ3Q7YWxsb2NhdGVkX3BvcnRzID09
IDAgJmFtcDsmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9tcF9hY3Rpb25fcmVnaXN0
ZXIoRVRIREVWX01QLCBldGhkZXZfc2VydmVyKSAmYW1wOyZhbXA7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgcnRlX2Vycm5vICE9IEVOT1RTVVApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBSVEVfRVRIREVWX0xPR19MSU5FKEVSUiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgJnF1b3Q7Q291bGQgbm90IHN0YXJ0ICVzIHNlcnZpY2UmcXVvdDssIEVUSERF
Vl9NUCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byB1bmxvY2s7PGJyPg0KK8Kg
IMKgIMKgIMKgfTxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCBldGhfZGV2ID0gZXRoX2Rldl9nZXQo
cG9ydF9pZCk7PGJyPg0KwqAgwqAgwqAgwqAgZXRoX2Rldi0mZ3Q7Zmxvd19mcF9vcHMgPSAmYW1w
O3J0ZV9mbG93X2ZwX2RlZmF1bHRfb3BzOzxicj4NCsKgIMKgIMKgIMKgIHN0cmxjcHkoZXRoX2Rl
di0mZ3Q7ZGF0YS0mZ3Q7bmFtZSwgbmFtZSwgc2l6ZW9mKGV0aF9kZXYtJmd0O2RhdGEtJmd0O25h
bWUpKTs8YnI+DQpAQCAtMjgyLDcgKzI5MCw4IEBAIHJ0ZV9ldGhfZGV2X3JlbGVhc2VfcG9ydChz
dHJ1Y3QgcnRlX2V0aF9kZXYgKmV0aF9kZXYpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
bWVtc2V0KGV0aF9kZXYtJmd0O2RhdGEsIDAsIHNpemVvZihzdHJ1Y3QgcnRlX2V0aF9kZXZfZGF0
YSkpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGV0aF9kZXYtJmd0O2RhdGEgPSBOVUxM
Ozxicj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGV0aF9kZXZfc2hhcmVkX2RhdGEt
Jmd0O2FsbG9jYXRlZF9wb3J0cy0tOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICgt
LWV0aF9kZXZfc2hhcmVkX2RhdGEtJmd0O2FsbG9jYXRlZF9wb3J0cyA9PSAwKTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9tcF9hY3Rpb25fdW5yZWdpc3RlcihF
VEhERVZfTVApOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGV0aF9kZXZfc2hhcmVkX2Rh
dGFfcmVsZWFzZSgpOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEv
bGliL2V0aGRldi9ldGhkZXZfcHJpdmF0ZS5jIGIvbGliL2V0aGRldi9ldGhkZXZfcHJpdmF0ZS5j
PGJyPg0KaW5kZXggMjg1ZDM3N2Q5MS4uMTg0Y2YzM2Y5OSAxMDA2NDQ8YnI+DQotLS0gYS9saWIv
ZXRoZGV2L2V0aGRldl9wcml2YXRlLmM8YnI+DQorKysgYi9saWIvZXRoZGV2L2V0aGRldl9wcml2
YXRlLmM8YnI+DQpAQCAtMiw2ICsyLDggQEA8YnI+DQrCoCAqIENvcHlyaWdodChjKSAyMDE4IEdh
w6t0YW4gUml2ZXQ8YnI+DQrCoCAqLzxicj4NCjxicj4NCisjaW5jbHVkZSAmbHQ7YXNzZXJ0Lmgm
Z3Q7PGJyPg0KKzxicj4NCsKgI2luY2x1ZGUgJmx0O2VhbF9leHBvcnQuaCZndDs8YnI+DQrCoCNp
bmNsdWRlICZsdDtydGVfZGVidWcuaCZndDs8YnI+DQo8YnI+DQpAQCAtNDc3LDMgKzQ3OSw5NCBA
QCBldGhfZGV2X3R4X3F1ZXVlX2NvbmZpZyhzdHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiwgdWludDE2
X3QgbmJfcXVldWVzKTxicj4NCsKgIMKgIMKgIMKgIGRldi0mZ3Q7ZGF0YS0mZ3Q7bmJfdHhfcXVl
dWVzID0gbmJfcXVldWVzOzxicj4NCsKgIMKgIMKgIMKgIHJldHVybiAwOzxicj4NCsKgfTxicj4N
Cis8YnI+DQorc3RhdGljIGludDxicj4NCitldGhkZXZfaGFuZGxlX3JlcXVlc3QoY29uc3Qgc3Ry
dWN0IGV0aGRldl9tcF9yZXF1ZXN0ICpyZXEpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzd2l0
Y2ggKHJlcS0mZ3Q7b3BlcmF0aW9uKSB7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBFVEhfUkVRX1NU
QVJUOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBydGVfZXRoX2Rldl9zdGFy
dChyZXEtJmd0O3BvcnRfaWQpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEVUSF9SRVFf
U1RPUDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcnRlX2V0aF9kZXZfc3Rv
cChyZXEtJmd0O3BvcnRfaWQpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUlOVkFMOzxicj4NCivCoCDCoCDCoCDC
oH08YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljX2Fzc2VydChzaXplb2Yoc3RydWN0IGV0aGRl
dl9tcF9yZXF1ZXN0KSAmbHQ7PSBSVEVfTVBfTUFYX1BBUkFNX0xFTiw8YnI+DQorwqAgwqAgwqAg
wqAmcXVvdDtldGhkZXYgTVAgcmVxdWVzdCBiaWdnZXIgdGhhbiBhdmFpbGFibGUgcGFyYW0gc3Bh
Y2UmcXVvdDspOzxicj4NCis8YnI+DQorc3RhdGljX2Fzc2VydChzaXplb2Yoc3RydWN0IGV0aGRl
dl9tcF9yZXNwb25zZSkgJmx0Oz0gUlRFX01QX01BWF9QQVJBTV9MRU4sPGJyPg0KK8KgIMKgIMKg
IMKgJnF1b3Q7ZXRoZGV2IE1QIHJlc3BvbnNlIGJpZ2dlciB0aGFuIGF2YWlsYWJsZSBwYXJhbSBz
cGFjZSZxdW90Oyk7PGJyPg0KKzxicj4NCitpbnQ8YnI+DQorZXRoZGV2X3NlcnZlcihjb25zdCBz
dHJ1Y3QgcnRlX21wX21zZyAqbXBfbXNnLCBjb25zdCB2b2lkICpwZWVyKTxicj4NCit7PGJyPg0K
K8KgIMKgIMKgIMKgY29uc3Qgc3RydWN0IGV0aGRldl9tcF9yZXF1ZXN0ICpyZXE8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA9IChjb25zdCBzdHJ1Y3QgZXRoZGV2X21wX3JlcXVlc3QgKilt
cF9tc2ctJmd0O3BhcmFtOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX21wX21z
ZyBtcF9yZXNwID0gezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5uYW1lID0gRVRIREVW
X01QLDxicj4NCivCoCDCoCDCoCDCoH07PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGV0aGRldl9t
cF9yZXNwb25zZSAqcmVzcDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmVzcCA9IChzdHJ1Y3Qg
ZXRoZGV2X21wX3Jlc3BvbnNlICopbXBfcmVzcC5wYXJhbTs8YnI+DQorwqAgwqAgwqAgwqBtcF9y
ZXNwLmxlbl9wYXJhbSA9IHNpemVvZigqcmVzcCk7PGJyPg0KK8KgIMKgIMKgIMKgcmVzcC0mZ3Q7
cmVzX29wID0gcmVxLSZndDtvcGVyYXRpb247PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIHJl
Y3YgY2xpZW50IHJlcXVlc3RzICovPGJyPg0KK8KgIMKgIMKgIMKgaWYgKG1wX21zZy0mZ3Q7bGVu
X3BhcmFtICE9IHNpemVvZigqcmVxKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXNw
LSZndDtlcnJfdmFsdWUgPSAtRUlOVkFMOzxicj4NCivCoCDCoCDCoCDCoGVsc2U8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXNwLSZndDtlcnJfdmFsdWUgPSBldGhkZXZfaGFuZGxlX3Jl
cXVlc3QocmVxKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHJ0ZV9tcF9yZXBseSgm
YW1wO21wX3Jlc3AsIHBlZXIpOzxicj4NCit9PGJyPg0KKzxicj4NCitpbnQ8YnI+DQorZXRoZGV2
X3JlcXVlc3QodWludDE2X3QgcG9ydF9pZCwgZW51bSBldGhkZXZfbXBfb3BlcmF0aW9uIG9wZXJh
dGlvbiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3Qg
YnVmX2xlbik8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBydGVfbXBfbXNnIG1wX3Jl
cSA9IHsgfTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX21wX3JlcGx5IG1wX3JlcGx5Ozxi
cj4NCivCoCDCoCDCoCDCoHN0cnVjdCBldGhkZXZfbXBfcmVxdWVzdCAqcmVxOzxicj4NCivCoCDC
oCDCoCDCoHN0cnVjdCB0aW1lc3BlYyB0cyA9IHsudHZfc2VjID0gNSwgLnR2X25zZWMgPSAwfTs8
YnI+DQorwqAgwqAgwqAgwqBpbnQgcmV0Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoc2l6
ZW9mKCpyZXEpICsgYnVmX2xlbiAmZ3Q7IFJURV9NUF9NQVhfUEFSQU1fTEVOKSB7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX0VUSERFVl9MT0dfTElORShFUlIsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7cmVx
dWVzdCAldSBwb3J0ICV1IGludmFsaWQgbGVuICV6dSZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvcGVyYXRpb24sIHBvcnRf
aWQsIGJ1Zl9sZW4pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUlOVkFM
Ozxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgc3RybGNweSg8YSBo
cmVmPSJodHRwOi8vbXBfcmVxLm5hbWUiIHJlbD0ibm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJn
ZXQ9Il9ibGFuayI+bXBfcmVxLm5hbWU8L2E+LCBFVEhERVZfTVAsIFJURV9NUF9NQVhfTkFNRV9M
RU4pOzxicj4NCivCoCDCoCDCoCDCoG1wX3JlcS5sZW5fcGFyYW0gPSBzaXplb2YoKnJlcSkgKyBi
dWZfbGVuOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqByZXEgPSAoc3RydWN0IGV0aGRldl9tcF9y
ZXF1ZXN0ICopbXBfcmVxLnBhcmFtOzxicj4NCivCoCDCoCDCoCDCoHJlcS0mZ3Q7b3BlcmF0aW9u
ID0gb3BlcmF0aW9uOzxicj4NCivCoCDCoCDCoCDCoHJlcS0mZ3Q7cG9ydF9pZCA9IHBvcnRfaWQ7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChidWZfbGVuICZndDsgMCk8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBtZW1jcHkocmVxLSZndDtjb25maWcsIGJ1ZiwgYnVmX2xlbik7PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoHJldCA9IHJ0ZV9tcF9yZXF1ZXN0X3N5bmMoJmFtcDttcF9y
ZXEsICZhbXA7bXBfcmVwbHksICZhbXA7dHMpOzxicj4NCivCoCDCoCDCoCDCoGlmIChyZXQgPT0g
MCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCBydGVfbXBfbXNn
ICptcF9yZXAgPSAmYW1wO21wX3JlcGx5Lm1zZ3NbMF07PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgY29uc3Qgc3RydWN0IGV0aGRldl9tcF9yZXNwb25zZSAqcmVzcDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoD0gKGNvbnN0IHN0cnVjdCBldGhkZXZfbXBfcmVz
cG9uc2UgKiltcF9yZXAtJmd0O3BhcmFtOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAocmVzcC0mZ3Q7ZXJyX3ZhbHVlID09IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gMDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBl
bHNlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2Vycm5vID0g
LXJlc3AtJmd0O2Vycl92YWx1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKG1w
X3JlcGx5Lm1zZ3MpOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
aWYgKHJldCAmbHQ7IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX0VUSERFVl9M
T0dfTElORShFUlIsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90
O3BvcnQgJXVwIGV0aGRldiBvcCAldSBmYWlsZWQmcXVvdDssIHBvcnRfaWQsIG9wZXJhdGlvbik7
PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQorfTxicj4NCmRpZmYgLS1naXQgYS9s
aWIvZXRoZGV2L2V0aGRldl9wcml2YXRlLmggYi9saWIvZXRoZGV2L2V0aGRldl9wcml2YXRlLmg8
YnI+DQppbmRleCBiMDdiMWI0YzQyLi5mNThmMTYxODcxIDEwMDY0NDxicj4NCi0tLSBhL2xpYi9l
dGhkZXYvZXRoZGV2X3ByaXZhdGUuaDxicj4NCisrKyBiL2xpYi9ldGhkZXYvZXRoZGV2X3ByaXZh
dGUuaDxicj4NCkBAIC03OSw0ICs3OSwzMCBAQCB2b2lkIGV0aF9kZXZfdHhxX3JlbGVhc2Uoc3Ry
dWN0IHJ0ZV9ldGhfZGV2ICpkZXYsIHVpbnQxNl90IHFpZCk7PGJyPg0KwqBpbnQgZXRoX2Rldl9y
eF9xdWV1ZV9jb25maWcoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsIHVpbnQxNl90IG5iX3F1ZXVl
cyk7PGJyPg0KwqBpbnQgZXRoX2Rldl90eF9xdWV1ZV9jb25maWcoc3RydWN0IHJ0ZV9ldGhfZGV2
ICpkZXYsIHVpbnQxNl90IG5iX3F1ZXVlcyk7PGJyPg0KPGJyPg0KKy8qIFVzZWQgdG8gYWxsb3cg
c3RhcnQvc3RvcCBmcm9tIHNlY29uZGFyeSAqLzxicj4NCisjZGVmaW5lIEVUSERFVl9NUMKgIMKg
IMKgICZxdW90O21wX2V0aGRldiZxdW90Ozxicj4NCis8YnI+DQorZW51bSBldGhkZXZfbXBfb3Bl
cmF0aW9uIHs8YnI+DQorwqAgwqAgwqAgwqBFVEhfUkVRX1NUQVJULDxicj4NCivCoCDCoCDCoCDC
oEVUSF9SRVFfU1RPUCw8YnI+DQorfTs8YnI+DQorPGJyPg0KK3N0cnVjdCBldGhkZXZfbXBfcmVx
dWVzdCB7PGJyPg0KK8KgIMKgIMKgIMKgdWludDE2X3Qgb3BlcmF0aW9uOzxicj4NCivCoCDCoCDC
oCDCoHVpbnQxNl90IHBvcnRfaWQ7PGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgcmVzZXJ2ZWQ7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHVpbnQ4X3QgY29uZmlnW107IC8qIG9wZXJhdGlvbiBz
cGVjaWZpYyAqLzxicj4NCit9Ozxicj4NCis8YnI+DQorc3RydWN0IGV0aGRldl9tcF9yZXNwb25z
ZSB7PGJyPg0KK8KgIMKgIMKgIMKgdWludDE2X3QgcmVzX29wOzxicj4NCivCoCDCoCDCoCDCoHVp
bnQxNl90IHBvcnRfaWQ7PGJyPg0KK8KgIMKgIMKgIMKgaW50MzJfdCBlcnJfdmFsdWU7PGJyPg0K
K307PGJyPg0KKzxicj4NCitpbnQgZXRoZGV2X3NlcnZlcihjb25zdCBzdHJ1Y3QgcnRlX21wX21z
ZyAqbXBfbXNnLCBjb25zdCB2b2lkICpwZWVyKTs8YnI+DQoraW50IGV0aGRldl9yZXF1ZXN0KHVp
bnQxNl90IHBvcnRfaWQsIGVudW0gZXRoZGV2X21wX29wZXJhdGlvbiBvcCw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgYnVmX2xlbik7PGJy
Pg0KKzxicj4NCsKgI2VuZGlmIC8qIF9FVEhfUFJJVkFURV9IXyAqLzxicj4NCmRpZmYgLS1naXQg
YS9saWIvZXRoZGV2L3J0ZV9ldGhkZXYuYyBiL2xpYi9ldGhkZXYvcnRlX2V0aGRldi5jPGJyPg0K
aW5kZXggZGQ3YzAwYmM5NC4uNDEzNjNhZjJjMyAxMDA2NDQ8YnI+DQotLS0gYS9saWIvZXRoZGV2
L3J0ZV9ldGhkZXYuYzxicj4NCisrKyBiL2xpYi9ldGhkZXYvcnRlX2V0aGRldi5jPGJyPg0KQEAg
LTE4MDAsNTQgKzE4MDAsNjEgQEAgcnRlX2V0aF9kZXZfc3RhcnQodWludDE2X3QgcG9ydF9pZCk8
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBpZiAoZGV2LSZndDtkYXRhLSZndDtkZXZfY29uZmlndXJl
ZCA9PSAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUlRFX0VUSERFVl9MT0dfTElO
RShJTkZPLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O0Rl
dmljZSB3aXRoIHBvcnRfaWQ9JSZxdW90O1BSSXUxNiZxdW90OyBpcyBub3QgY29uZmlndXJlZC4m
cXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcG9ydF9pZCk7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgJnF1b3Q7RGV2aWNlIHdpdGggcG9ydF9pZD0lJnF1b3Q7UFJJdTE2JnF1b3Q7IGlzIG5vdCBj
b25maWd1cmVkLiZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBwb3J0X2lkKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCByZXR1cm4gLUVJTlZBTDs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgaWYgKGRldi0mZ3Q7ZGF0YS0mZ3Q7ZGV2X3N0YXJ0ZWQgIT0gMCkgezxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFJURV9FVEhERVZfTE9HX0xJTkUoSU5GTyw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtEZXZpY2Ugd2l0aCBwb3J0X2lkPSUmcXVv
dDtQUkl1MTYmcXVvdDsgYWxyZWFkeSBzdGFydGVkJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBvcnRfaWQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O0RldmljZSB3aXRoIHBvcnRf
aWQ9JSZxdW90O1BSSXUxNiZxdW90OyBhbHJlYWR5IHN0YXJ0ZWQmcXVvdDssPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcG9ydF9pZCk7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIDA7PGJyPg0KwqAgwqAgwqAgwqAg
fTxicj4NCjxicj4NCi3CoCDCoCDCoCDCoHJldCA9IHJ0ZV9ldGhfZGV2X2luZm9fZ2V0KHBvcnRf
aWQsICZhbXA7ZGV2X2luZm8pOzxicj4NCi3CoCDCoCDCoCDCoGlmIChyZXQgIT0gMCk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCivCoCDCoCDCoCDCoGlmIChy
dGVfZWFsX3Byb2Nlc3NfdHlwZSgpID09IFJURV9QUk9DX1BSSU1BUlkpIHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXQgPSBydGVfZXRoX2Rldl9pbmZvX2dldChwb3J0X2lkLCAmYW1w
O2Rldl9pbmZvKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0ICE9IDApPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQo8
YnI+DQotwqAgwqAgwqAgwqByZXN0b3JlX2ZsYWdzID0gcnRlX2V0aF9nZXRfcmVzdG9yZV9mbGFn
cyhkZXYsIFJURV9FVEhfU1RBUlQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3Rv
cmVfZmxhZ3MgPSBydGVfZXRoX2dldF9yZXN0b3JlX2ZsYWdzKGRldiwgUlRFX0VUSF9TVEFSVCk7
PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgLyogTGV0cyByZXN0b3JlIE1BQyBub3cgaWYgZGV2aWNl
IGRvZXMgbm90IHN1cHBvcnQgbGl2ZSBjaGFuZ2UgKi88YnI+DQotwqAgwqAgwqAgwqBpZiAoKCpk
ZXZfaW5mby5kZXZfZmxhZ3MgJmFtcDsgUlRFX0VUSF9ERVZfTk9MSVZFX01BQ19BRERSKSAmYW1w
OyZhbXA7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgKHJlc3RvcmVfZmxhZ3MgJmFtcDsgUlRFX0VU
SF9SRVNUT1JFX01BQ19BRERSKSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBldGhfZGV2
X21hY19yZXN0b3JlKGRldiwgJmFtcDtkZXZfaW5mbyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgLyogUmVzdG9yZSBNQUMgbm93IGlmIGRldmljZSBkb2VzIG5vdCBzdXBwb3J0IGxpdmUg
Y2hhbmdlICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCgqZGV2X2luZm8uZGV2
X2ZsYWdzICZhbXA7IFJURV9FVEhfREVWX05PTElWRV9NQUNfQUREUikgJmFtcDsmYW1wOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChyZXN0b3JlX2ZsYWdzICZhbXA7IFJURV9F
VEhfUkVTVE9SRV9NQUNfQUREUikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZXRoX2Rldl9tYWNfcmVzdG9yZShkZXYsICZhbXA7ZGV2X2luZm8pOzxicj4NCjxicj4N
Ci3CoCDCoCDCoCDCoGRpYWcgPSBkZXYtJmd0O2Rldl9vcHMtJmd0O2Rldl9zdGFydChkZXYpOzxi
cj4NCi3CoCDCoCDCoCDCoGlmIChkaWFnID09IDApPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZGV2LSZndDtkYXRhLSZndDtkZXZfc3RhcnRlZCA9IDE7PGJyPg0KLcKgIMKgIMKgIMKgZWxz
ZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBldGhfZXJyKHBvcnRfaWQsIGRp
YWcpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpYWcgPSBkZXYtJmd0O2Rldl9vcHMt
Jmd0O2Rldl9zdGFydChkZXYpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChkaWFn
ID09IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGV2LSZndDtk
YXRhLSZndDtkZXZfc3RhcnRlZCA9IDE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxz
ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBldGhfZXJy
KHBvcnRfaWQsIGRpYWcpOzxicj4NCjxicj4NCi3CoCDCoCDCoCDCoHJldCA9IGV0aF9kZXZfY29u
ZmlnX3Jlc3RvcmUoZGV2LCAmYW1wO2Rldl9pbmZvLCByZXN0b3JlX2ZsYWdzLCBwb3J0X2lkKTs8
YnI+DQotwqAgwqAgwqAgwqBpZiAocmV0ICE9IDApIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBSVEVfRVRIREVWX0xPR19MSU5FKEVSUiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAmcXVvdDtFcnJvciBkdXJpbmcgcmVzdG9yaW5nIGNvbmZpZ3VyYXRpb24g
Zm9yIGRldmljZSAocG9ydCAldSk6ICVzJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHBvcnRfaWQsIHJ0ZV9zdHJlcnJvcigtcmV0KSk7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0X3N0b3AgPSBydGVfZXRoX2Rldl9zdG9wKHBvcnRfaWQpOzxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXRfc3RvcCAhPSAwKSB7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gZXRoX2Rldl9jb25maWdfcmVzdG9yZShkZXYsICZh
bXA7ZGV2X2luZm8sIHJlc3RvcmVfZmxhZ3MsIHBvcnRfaWQpOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIChyZXQgIT0gMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFJURV9FVEhERVZfTE9HX0xJTkUoRVJSLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O0ZhaWxlZCB0byBzdG9wIGRldmlj
ZSAocG9ydCAldSk6ICVzJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHBvcnRfaWQsIHJ0ZV9zdHJlcnJvcigtcmV0X3N0b3ApKTs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7RXJyb3IgZHVyaW5nIHJlc3RvcmluZyBjb25m
aWd1cmF0aW9uIGZvciBkZXZpY2UgKHBvcnQgJXUpOiAlcyZxdW90Oyw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcG9ydF9pZCwgcnRlX3N0cmVy
cm9yKC1yZXQpKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXRf
c3RvcCA9IHJ0ZV9ldGhfZGV2X3N0b3AocG9ydF9pZCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldF9zdG9wICE9IDApIHs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBSVEVfRVRIREVWX0xPR19MSU5FKEVS
Uiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAmcXVvdDtGYWlsZWQgdG8gc3RvcCBkZXZpY2UgKHBvcnQgJXUpOiAlcyZxdW90
Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcG9ydF9pZCwgcnRlX3N0cmVycm9yKC1yZXRfc3RvcCkpOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCi3CoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBpZiAoZGV2LSZndDtkYXRhLSZndDtk
ZXZfY29uZi5pbnRyX2NvbmYubHNjID09IDApIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoZGV2LSZndDtkZXZfb3BzLSZndDtsaW5rX3VwZGF0ZSA9PSBOVUxMKTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRU5PVFNVUDs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBkZXYtJmd0O2Rldl9vcHMtJmd0O2xpbmtfdXBkYXRlKGRldiwg
MCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGRldi0mZ3Q7ZGF0YS0mZ3Q7ZGV2
X2NvbmYuaW50cl9jb25mLmxzYyA9PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgKGRldi0mZ3Q7ZGV2X29wcy0mZ3Q7bGlua191cGRhdGUgPT0gTlVMTCk8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gLUVOT1RTVVA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGV2
LSZndDtkZXZfb3BzLSZndDtsaW5rX3VwZGF0ZShkZXYsIDApOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqB9IGVsc2Ugezxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoC8qIGluIHNlY29uZGFyeSwgcHJveHkgdG8gcHJpbWFyeSAqLzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IGV0aGRldl9yZXF1ZXN0KHBvcnRfaWQsIEVUSF9SRVFf
U1RBUlQsIE5VTEwsIDApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgIT0g
MCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxi
cj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCAvKiBleHBvc2Ugc2VsZWN0
aW9uIG9mIFBNRCBmYXN0LXBhdGggZnVuY3Rpb25zICovPGJyPg0KQEAgLTE4ODAsOSArMTg4Nywx
NCBAQCBydGVfZXRoX2Rldl9zdG9wKHVpbnQxNl90IHBvcnRfaWQpPGJyPg0KwqAgwqAgwqAgwqAg
LyogcG9pbnQgZmFzdC1wYXRoIGZ1bmN0aW9ucyB0byBkdW1teSBvbmVzICovPGJyPg0KwqAgwqAg
wqAgwqAgZXRoX2Rldl9mcF9vcHNfcmVzZXQocnRlX2V0aF9mcF9vcHMgKyBwb3J0X2lkKTs8YnI+
DQo8YnI+DQotwqAgwqAgwqAgwqByZXQgPSBkZXYtJmd0O2Rldl9vcHMtJmd0O2Rldl9zdG9wKGRl
dik7PGJyPg0KLcKgIMKgIMKgIMKgaWYgKHJldCA9PSAwKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGRldi0mZ3Q7ZGF0YS0mZ3Q7ZGV2X3N0YXJ0ZWQgPSAwOzxicj4NCivCoCDCoCDCoCDC
oGlmIChydGVfZWFsX3Byb2Nlc3NfdHlwZSgpID09IFJURV9QUk9DX1BSSU1BUlkpIHs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBkZXYtJmd0O2Rldl9vcHMtJmd0O2Rldl9zdG9w
KGRldik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCA9PSAwKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRldi0mZ3Q7ZGF0YS0mZ3Q7ZGV2X3N0
YXJ0ZWQgPSAwOzxicj4NCivCoCDCoCDCoCDCoH0gZWxzZSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0ID0gZXRoZGV2X3JlcXVlc3QocG9ydF9pZCwgRVRIX1JFUV9TVE9QLCBOVUxM
LCAwKTs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCsKgIMKgIMKgIMKgIHJ0ZV9ldGhk
ZXZfdHJhY2Vfc3RvcChwb3J0X2lkLCByZXQpOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIHJldHVy
biByZXQ7PGJyPg0KLS0gPGJyPg0KMi40Ny4yPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2
Pg0K
--00000000000002e0e5063982ab31--
