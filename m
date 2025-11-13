Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E45CD5BAE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 09:50:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68BAE40B9C;
	Thu, 13 Nov 2025 10:49:59 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 56B6D40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 10:49:58 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8b22a30986fso64427085a.2
 for <dev@dpdk.org>; Thu, 13 Nov 2025 01:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763027398; x=1763632198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ihvROuAMPw7PJ4ISZI/N4PyflrJuvhwZQ9a5f1yGo4=;
 b=XkV/9k4C1l5vKOo7HuegYk0TuzPd8DHsFZRm/PpsYg/HnV85b/AB/oeHfjfrozyk7O
 SlYcd2/s22XMjqTMPT0/XNTHrdk9wqwYIBVO5Jddgi86wu4c9TN3Urm4MRoO9ok006ZK
 lx1Dn/ZB9Lv2akRj5GpoVVpmbOmRXFQekyo+z/qvSCLkD/WOB8Whk6rDsfE+I8JYoMub
 BoYPZInZTKwjaHiM0WujwOXelu48pmTsrKsiEY2obir0Jo5pG6tAN8gcjAV/ZArdTpZB
 zUur8z6Cf8xsQb5avCGq1rtVyEBYYpjZ2RcbIr/3Obgb8O39VyOVt2hu/x+9t4d23lXX
 a6qw==
X-Gm-Message-State: AOJu0YzbQXqYRAuqB5u0VxBTHI1ddCYw/bci3sqbVN1XzHzt0rLvXY2+
 OsvhxdNk7eCqCjKO00yQflHVgowGZALBJv9uYUAKwH4D6QaAto0cRvAmjarPgm8ogsVbcScEqpe
 iujZvfEmRVMLv4KqWrsAz30VcyzLxXX8=
X-Gm-Gg: ASbGnctVZ5G0Mb3SrXkqf668lsS4UprIP/IpJ13pUhrQDGRFZxJITwk3MEjxjVMP86u
 6l5LT5SBT+s1Krw7tyirmSfbc2qSt8KIM2tgpQulbhSKiPPuMoGDse0RwScJ16nzPFSw3xdHwl4
 lVrBvo3CYc7XWK9NPM8XrwsSSgddj8tZQX4dtaaIo2Flgc1/KNISE7D7byeWokbq2+cS+tdMWLB
 i4IDFJyUXsOkPWBpsyg/XGvaUDI8nOnSfo1c2LaEiqgnz+TQ3qwLSc6Lg==
X-Google-Smtp-Source: AGHT+IHOuwETNzgS6iYZDBxhE/v1OPB9mhiAX+TImvr5lMw+DUxNVRw+eSslEoWlHlyhR7GybyYsxpiRiAZZh2oXVoo=
X-Received: by 2002:a05:620a:1790:b0:8b2:24b9:f57 with SMTP id
 af79cd13be357-8b29b84979bmr840126085a.88.1763027397543; Thu, 13 Nov 2025
 01:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <20251113052931.1784953-1-hemant.agrawal@nxp.com>
 <20251113052931.1784953-4-hemant.agrawal@nxp.com>
In-Reply-To: <20251113052931.1784953-4-hemant.agrawal@nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Thu, 13 Nov 2025 10:49:46 +0100
X-Gm-Features: AWmQ_bkhIq15bJUBJOrRvGCMyzMUBkFQv6ds8nHaQKIhr7V3YvHYWp1hY4yheTk
Message-ID: <CAHHRULWaiPD9qbVG0ujbMHZ+DoOH+Yp8vCLNRSbHvvSKcBOvVA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] net/dpaa2: bifurcate close into close and deinit
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Hemant,

Le jeu. 13 nov. 2025 =C3=A0 06:30, Hemant Agrawal <hemant.agrawal@nxp.com> =
a =C3=A9crit :
>
> The close function was overloaded to be also used as deinit function.
> This can cause issues when using functions like hotplug.
>
> This patch cleans up the code and implement separate close and deinit
>
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
>  drivers/net/dpaa2/dpaa2_ethdev.c | 92 ++++++++++++++++++--------------
>  1 file changed, 51 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_e=
thdev.c
> index f82c50341d..0cd875d715 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -1524,53 +1524,14 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
>  static int
>  dpaa2_dev_close(struct rte_eth_dev *dev)
>  {
> -       struct dpaa2_dev_priv *priv =3D dev->data->dev_private;
> -       struct fsl_mc_io *dpni =3D dev->process_private;
> -       int i, ret;
> -       struct rte_eth_link link;
> -
>         PMD_INIT_FUNC_TRACE();
>
>         if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY)
>                 return 0;
>
> -       if (!dpni) {
> -               DPAA2_PMD_WARN("Already closed or not started");
> -               return -EINVAL;
> -       }
> -
>         dpaa2_tm_deinit(dev);
>         dpaa2_flow_clean(dev);
> -       /* Clean the device first */
> -       ret =3D dpni_reset(dpni, CMD_PRI_LOW, priv->token);
> -       if (ret) {
> -               DPAA2_PMD_ERR("Failure cleaning dpni device: err=3D%d", r=
et);
> -               return ret;
> -       }
> -
> -       memset(&link, 0, sizeof(link));
> -       rte_eth_linkstatus_set(dev, &link);
> -
> -       /* Free private queues memory */
> -       dpaa2_free_rx_tx_queues(dev);
> -       /* Close the device at underlying layer*/
> -       ret =3D dpni_close(dpni, CMD_PRI_LOW, priv->token);
> -       if (ret) {
> -               DPAA2_PMD_ERR("Failure closing dpni device with err code =
%d",
> -                       ret);
> -       }
> -
> -       /* Free the allocated memory for ethernet private data and dpni*/
> -       priv->hw =3D NULL;
> -       dev->process_private =3D NULL;
> -       rte_free(dpni);
>
> -       for (i =3D 0; i < MAX_TCS; i++)
> -               rte_free(priv->extract.tc_extract_param[i]);
> -
> -       rte_free(priv->extract.qos_extract_param);
> -
> -       DPAA2_PMD_INFO("%s: netdev deleted", dev->data->name);
>         return 0;
>  }
>
> @@ -2891,6 +2852,55 @@ dpaa2_get_devargs(struct rte_devargs *devargs, con=
st char *key)
>         return 1;
>  }
>
> +static int
> +dpaa2_dev_deinit(struct rte_eth_dev *dev)
> +{
> +       struct dpaa2_dev_priv *priv =3D dev->data->dev_private;
> +       struct fsl_mc_io *dpni =3D dev->process_private;
> +       int i, ret;
> +       struct rte_eth_link link;
> +
> +       PMD_INIT_FUNC_TRACE();
> +
> +       if (!dpni) {
> +               DPAA2_PMD_WARN("Already closed or not started");
> +               return -EINVAL;
> +       }
> +
> +       /* Clean the device first */
> +       ret =3D dpni_reset(dpni, CMD_PRI_LOW, priv->token);
> +       if (ret) {
> +               DPAA2_PMD_ERR("Failure cleaning dpni device: err=3D%d", r=
et);
> +               return ret;
> +       }
> +
> +       memset(&link, 0, sizeof(link));
> +       rte_eth_linkstatus_set(dev, &link);
> +
> +       /* Free private queues memory */
> +       dpaa2_free_rx_tx_queues(dev);
> +       /* Close the device at underlying layer*/
> +       ret =3D dpni_close(dpni, CMD_PRI_LOW, priv->token);
> +       if (ret) {
> +               DPAA2_PMD_ERR("Failure closing dpni device with err code =
%d",
> +                       ret);
> +       }
> +
> +       /* Free the allocated memory for ethernet private data and dpni*/
> +       priv->hw =3D NULL;
> +       dev->process_private =3D NULL;
> +       rte_free(dpni);
> +
> +       for (i =3D 0; i < MAX_TCS; i++)
> +               rte_free(priv->extract.tc_extract_param[i]);
> +
> +       rte_free(priv->extract.qos_extract_param);
> +
> +       DPAA2_PMD_INFO("%s: netdev deleted", dev->data->name);
> +       return 0;
> +}
> +
> +
>  static int
>  dpaa2_dev_init(struct rte_eth_dev *eth_dev)
>  {
> @@ -3177,7 +3187,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
>
>         return 0;
>  init_err:
> -       dpaa2_dev_close(eth_dev);
> +       dpaa2_dev_deinit(eth_dev);
>
>         return ret;
>  }
> @@ -3381,7 +3391,7 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev=
)
>
>         eth_dev =3D rte_eth_dev_allocated(dpaa2_dev->device.name);
>         if (eth_dev) {
> -               dpaa2_dev_close(eth_dev);
> +               dpaa2_dev_deinit(eth_dev);
>                 ret =3D rte_eth_dev_release_port(eth_dev);
>         }

When a DPDK application stops, dpaa2_dev_close is no longer called.
This happens because eal_cleanup() invokes rte_fslmc_close(), which
then calls the remove function (rte_dpaa2_remove) for each DPAA2
Ethernet driver. As a result, dpaa2_tm_deinit() and dpaa2_flow_clean()
are no longer executed.

Another issue is that dpaa2_dev_deinit is now called in secondary
process, which was not the case before this commit.

For comparison, other drivers like ixgbe call their close method from
the bus=E2=80=99s remove callback. I don=E2=80=99t see any issue doing the =
same
here=E2=80=94calling close during remove if the Ethernet device is still
allocated.

As far as I know, there is no counterpart to rte_eth_dev_close() in
the DPDK API (there could have been an rte_eth_dev_open()). The open
path is always triggered by the bus=E2=80=99s probe callback.
Because of this, it is expected that dpaa2_dev_init is called from the
plug/probe path, while the corresponding deinit logic is handled in
the close callback.

One more point: why isn=E2=80=99t dpaa2_tx_sg_pool_init() done directly in
dpaa2_dev_init(), with its corresponding cleanup performed in
dpaa2_dev_close()?

Maxime Leroy
