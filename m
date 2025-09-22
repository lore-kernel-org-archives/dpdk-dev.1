Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA0CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 08:23:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D813740653;
	Mon, 22 Sep 2025 10:23:04 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by mails.dpdk.org (Postfix) with ESMTP id B36CA4060A;
 Mon, 22 Sep 2025 10:23:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5EB5ywMsUfLdghWhbHsWHajp5ZYipd7RLAjIKlD09U3RP4Pxa02eCVgN3fgB5ZOzKldtfc3XMYQzN5a0YV/YpRpVCrew6ZY2EebObO7seTG8ukF6sxQo06C7oOwKYdiwgpaTCWf5bW/dVuEXBFF5qAceroKe/LjPafgiFSrCqP2ASWjn1FWeWMpwjYLS1BeUs9btdyphwB2+IJKeOyalm3nLF+1Q32ci5AiLSFdVkxTEVr7V4Ll2evGCC9FZWP0263OMfK2pvAwhGY7W1A1SBJl5WlAmWfxitanrPniBCN+kM7xIGpeNN1JfSerkJ2eRJaPRfFkpE5vRiWzvsoWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iUtm/1ZnRDVpWHGQh82rCEdOT/TgoteUBjRgnijH14=;
 b=Oy89JCZ5wU+S7O/+2zx382WNOB1lKfQ/dkt4H3EAchiwgzLo28ivD04SLZtkTQT5WHgMQqJNqDy7FsySOu4/t7Rvssn9CwSyS/XAwhkShje6ztGAuOVdI24ofHIU/vliC8ymrds/L9ypexW9Y7EbGc1+3hbBsr9X9J3WyTb1fhSjcOSkRjmdYXtWRX5krEB8p1HBu6PB6gEXFskjPlX6/irMy/IRztFX6vmkdAf3N3l/56SdPYO7VX8kG5M/4k+pS4cdLqQUqgly1hyFyeZC0585Fy2mlr3uhuuo42NEc3Hc5Hv0nd4yxKxUc5lb7Q4ah9zpQC1u+B23OTCZTeEXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iUtm/1ZnRDVpWHGQh82rCEdOT/TgoteUBjRgnijH14=;
 b=d3j+ToamrZi7HOuZSaj4sWedTnU5TASSOWf9LoyCUGMWbrecms6ggWWAYzdKtrKUNyfjuYFUXoOdqum4pQT8js4s/pbhULfGqPh2e14xwZiUtu2B5eOmiwRSwYdL1jWHqaYQgM/GvswVXia7CkDsOZiUeBrx7IRBb0XY54SwICaP6RGS7Zz9PPktv1IIaloK7c9pTK7wTqjiIIIwHy73rhwPQKP/Su5xAkDWmwrnpqd3mmW8OX8ixD7SzgGTIbqZnqmDTI/dlNTJUnoDg9l+5PZ+2EceXDGVkr/jLYeuzostgWTOa2+3VX0750eAEBZl8WVBboQ0ch73oq1ps2YXbg==
Received: from MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 08:23:00 +0000
Received: from MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8]) by MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 08:22:59 +0000
From: Chenbo Xia <chenbox@nvidia.com>
To: Konrad Sztyber <konrad.sztyber@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Chaoyong He <chaoyong.he@corigine.com>,
 Stephen Hemminger <stephen@networkplumber.org>, David Marchand
 <david.marchand@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>, Nipun Gupta
 <nipun.gupta@amd.com>, Anatoly Burakov <anatoly.burakov@intel.com>, Long Wu
 <long.wu@corigine.com>, Zerun Fu <zerun.fu@corigine.com>
Subject: Re: [PATCH v3] bus/pci: don't open uio device in secondary process
Thread-Topic: [PATCH v3] bus/pci: don't open uio device in secondary process
Thread-Index: AQHbG88D+lTTcA6f0kqeaHijkw52srSg/ImA
Date: Mon, 22 Sep 2025 08:22:59 +0000
Message-ID: <B7194C63-9B63-4E74-876F-C0B83CD113FA@nvidia.com>
References: <20240829085724.270041-1-konrad.sztyber@intel.com>
 <20241011111533.20746-1-konrad.sztyber@intel.com>
In-Reply-To: <20241011111533.20746-1-konrad.sztyber@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6103:EE_|SA0PR12MB4430:EE_
x-ms-office365-filtering-correlation-id: 0f2e22a3-13fe-4525-d30f-08ddf9b13de0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qu4IN2VPjQVa+Spk7sMPdUbMDEF6sV7UQVQEDuXoUZzxwpI96fcHMmp2X3VV?=
 =?us-ascii?Q?vKQsZl59+0+IbATjmRTFu7enfRhKxeN0GmbqbVW+O/dkzkgwYUt4Dlc3rlwi?=
 =?us-ascii?Q?/51iU436zFwlqejL1yDPEi7otl79RdNfay4h3zTWJsfcPeAr9Wo7dbHHuS57?=
 =?us-ascii?Q?bukfILLGT4Kl/Yh68hMVaXigU9zjqZnfn6QEQ12//xQpTdKgI9ZRnOreDUlE?=
 =?us-ascii?Q?fxGHQZWneLuCHS5BZx4nYlxhLpOkaWqMlPLWoPkgxtYb/WvQ6BTvibvN7pEe?=
 =?us-ascii?Q?yLkZn0wftiKjlGj8PhOa9Yatp9h6St/SRMLZgr9UwiNh4kI/Ea9UwPmiaKph?=
 =?us-ascii?Q?CU1XJuNKUuPdjM2A+BX3LuoZjuLFNgOzw4CqCXKsyS+Z4X9XeQJGtXqcAWR5?=
 =?us-ascii?Q?G8FDOSYl2S7ONypWZ18jDfya1ieW9QhxiV2B3ttPtXMMinTfN3zkGedYEUkf?=
 =?us-ascii?Q?sgNGLy2GtUQ49PWM4jhv9cdyWQAUV9jhXIJSuz283+BbCecN+mPdQ1ngusfP?=
 =?us-ascii?Q?l4nRHRcSHYFr6IUJNtXSLiueHytSYCP4rUrWWcUacDcsBtT+lcxb4rxSVn4B?=
 =?us-ascii?Q?rBoA7Ohq1sRvkTpbJdyFmpNDzPUOZXtkujTQgoNJVvMCFOEmo4YOaYwpp6yG?=
 =?us-ascii?Q?UiO+ari5o4K/nJnlhBVE4kHAhHZtdOR394ATbf8Od6vDLA9qTj6tKKKRaA+X?=
 =?us-ascii?Q?c6EfoRvHeLGbYBf4sN6v66Eq0q45NZjwIWvbYIX1LkgU7xfu97MeYlRJ3dTg?=
 =?us-ascii?Q?D353+k4YFEb9iLJaZE3v/Gc/PjITe9d7VjuJHm40byHUncC3Lgtf4XVSTs9V?=
 =?us-ascii?Q?oJtUbkCZZ2yuvrX2Zx6G2BCtmbIX3iDfObqtcMEewE8+lxJRTgQ8oKNRkrrx?=
 =?us-ascii?Q?Zy40OHdGIOAIVbiOh2ECjtgs8qRJEhTqzhXBSgdA5C6FsJ87F0yCelbP318W?=
 =?us-ascii?Q?RPKzE24i2OHOmZg5qTOt4MsefYmmI7RD/Noi/C0hyMOqk15mNXNUH4JLHsNP?=
 =?us-ascii?Q?dQfgfH83V4VV4QXkwGd00aUUmhKQH75XrUScrD8sEzF5SPJH4d3v0oVSDWkl?=
 =?us-ascii?Q?qqy6VcGY1+A12s1Ti0Lm8hDmDGmLWEiVZ4ZYxMoq6l7rQL4CfSpb40N9QKak?=
 =?us-ascii?Q?NTZ+i5qTsfwD29jlywj/3zgIi03vlBFDJWI63sB4y1RQE9gb4lQVnWtTzg9e?=
 =?us-ascii?Q?yw9SRalA7JFi7eS0isXQLnmuqHgpWxw08QrnzZdQIQxzgVn0Gp5IYXs/4+Z7?=
 =?us-ascii?Q?dpNDNq7pBuktuXwYVk76RzNb0f8jkklcX+57t+hDVcA3MHVW5H26d79jOHwq?=
 =?us-ascii?Q?TPt61HWrgOdySC7BPF4Vy86/2mMrMyD5G2RtZCkEYyF2/UXqtOxIcMXevHi3?=
 =?us-ascii?Q?pTEJbqeeYwpBDkjq/yg1wmwGHU1INTmoM+kyZdJYggsFdlxWsyM1VH6L4mVV?=
 =?us-ascii?Q?XqLknQ5ZlhSC4fpjIyvEI9RGQv3TO0KiWVWnnSUsGga2yCCXGRruKLKkM/cL?=
 =?us-ascii?Q?Yuq1LJL6A07AihU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6103.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?szpRR6hS2aeBRSkZ6Dk+eVlIL0F284CE+p6SShQydVGVFJlhAntGm5nihKCI?=
 =?us-ascii?Q?A+odLg9JA5S+mM2fa4bIF+PfttKC2SSFywQ+SUOHM+xiw6QL6QLhgmP1GjlT?=
 =?us-ascii?Q?4j7whioZ6WPImszu8HKjE+3jgi0BFKem+A6uX/UikexlsWL0a/iVcvV07cuF?=
 =?us-ascii?Q?jJqKKarETcfGP/G6hwgnUjDc0oKLwkF4UBWjFSK+cowAUh7zkf9T64z/dpR+?=
 =?us-ascii?Q?SBnw+w4gJpkS8v3oyyW8x+I9WaXlj8hyJkuT6oC0nQ2DwoRV08ckzPPuwCWA?=
 =?us-ascii?Q?PkFHcQOpcDV09FSLKJ+iiVRsr3gMyAja4icPjeRdeBPuhKekCo6ZXaNA03/n?=
 =?us-ascii?Q?jWVPDmgvF7StPUmGiWlCLG8K4s1G6ZbImwGm+HepERhN6uWBORrKKZNeVBwF?=
 =?us-ascii?Q?CuMTnM6Rnht9g/wc3+flXQGKEmajxpAbKQ7ZBPy5F4Osb/q8FtvgTGScBrbD?=
 =?us-ascii?Q?0bMi6nds20vQoxS506/ySeygi/GyjkMze1rDvT1PRApSxLoCdCkl3RlDNlrJ?=
 =?us-ascii?Q?AmRZJ+URF2QBPeWKK7DeT7Mqz4KgkhZQdg0UjnLbUf8SEVVTrQjyZRMyF0f9?=
 =?us-ascii?Q?0YqbmJNI1kebBqLMbZZ2Wimiu8bf5/UExlQmSMjW+/io+uVZHbCaAHOXjPfX?=
 =?us-ascii?Q?yPoaM+6+M7S2GqhdWBbj24tv9peSk1K/YFlmgxxyUlOV2vLh0tQ79z2ppt4Z?=
 =?us-ascii?Q?US38kuoZ2i0BB5mqcAoqdApjXj1XcdNGRBoWIMQYiJZQmC3LJhjGknpuC/+O?=
 =?us-ascii?Q?q0f1WXMnHuFBTZ+awwFDWuVxLdRNUGtoMDud7mL580LgfAbIoPtvY4LQn/f+?=
 =?us-ascii?Q?ExmPNG+mNb0E9sQTTFKwvK99aq7AMr7hoYlb8vi9LNQe58mxwod4l9vFTjFy?=
 =?us-ascii?Q?+HyWPgFcq3Fg+RaM3MbggaeuBkX6eR9d9A4U5/snaTtrLiPbWUfIsH683u9s?=
 =?us-ascii?Q?sdqMqnt69/liA2zJ+S0y9JCMny8Ug856SuWL+pTow/7b7+HmsmXVGTBgjsW9?=
 =?us-ascii?Q?3+87d+gKuFTkJTyRN1i8fC21iBijvujqTJCx4kfe8HlCdaW8LinmvUI6Lr13?=
 =?us-ascii?Q?M0QdCtW0+yWmvU1o9pYpP5xk1YNJuJlBzm+7b5V8UCnn/DrHnU+C+yrDYVXL?=
 =?us-ascii?Q?MI6GRrytrQzWntroV/V3iI/P07i3ndxvZjssd1kHSjT8SLtwEnYqwxrErdPK?=
 =?us-ascii?Q?O46oT3bDdSV3oyeWmgeF+2Eb+aPnphC5U9EPRdR0C75OxygwJIXMdLGchIlg?=
 =?us-ascii?Q?t43TkblNfjhr2kYGKj7F9u774d4rB/NRueF7EoVy0BIuvXhoNx02YeUwYXQT?=
 =?us-ascii?Q?XLmOIZAq/YGZb4J5bt6YInQLDF0+lRgEPPGFBCa10HR80q2V6Mcc6d4Lv/pM?=
 =?us-ascii?Q?shfkOZtzE++GvdaphehYvZSSD9EdWfLhVy/8Rt81+IhkoEXtm4faWTeDout+?=
 =?us-ascii?Q?9LTDciKhq4gtZGs1zajTPd7pIH0Mx5q/yo1+ew0tpxN3C3YOK3Con9jTtjN2?=
 =?us-ascii?Q?hV0iGaGOzoZ3eMSbzewuwP+9vwm7j7fUnfhmrXo3pz2Hxfku4WNiFIWXzvsC?=
 =?us-ascii?Q?ijYHQB/D/JKal/u68ubQiW2PKMWO7E3kaZXku/Bu?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AAC4AE7CBAEA6D458FAE8C5AF35DFFA6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2e22a3-13fe-4525-d30f-08ddf9b13de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 08:22:59.8808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aZIx8zKPTeVGF0Yp1DOrixfUykLKmH59DFpfy0O+asjVTlVGpBYEhW1p/Hweg1rKH0SBx7706gYHeiKofNMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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

Hi Konrad,

> On Oct 11, 2024, at 19:15, Konrad Sztyber <konrad.sztyber@intel.com> wrot=
e:
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The uio_pci_generic driver clears the bus master bit when the device
> file is closed. So, when the secondary process terminates after probing
> a device, that device becomes unusable in the primary process.
>=20
> To avoid that, the device file is now opened only in the primary process
> and the secondary gets it over UNIX domain socket via SCM_RIGHTS.
>=20
> Fixes: 847d78fb9530 ("bus/pci: fix FD in secondary process")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Konrad Sztyber <konrad.sztyber@intel.com>
> ---
> v3:
>  Use the rte_mp_* infrastructure to pass the uio fd from the primary
>  process to the secondary.
> v2:
>  Fixed coding style issues.
> ---
> drivers/bus/pci/linux/pci_uio.c | 140 ++++++++++++++++++++++++++++----
> 1 file changed, 126 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/bus/pci/linux/pci_uio.c b/drivers/bus/pci/linux/pci_=
uio.c
> index 4c1d3327a9..220390d921 100644
> --- a/drivers/bus/pci/linux/pci_uio.c
> +++ b/drivers/bus/pci/linux/pci_uio.c
> @@ -21,14 +21,22 @@
> #include <rte_bus_pci.h>
> #include <rte_common.h>
> #include <rte_malloc.h>
> +#include <rte_eal.h>
> +#include <rte_errno.h>
>=20
> #include "eal_filesystem.h"
> #include "pci_init.h"
> #include "private.h"
>=20
> void *pci_map_addr =3D NULL;
> +static int pci_uio_dev_count;
>=20
> #define OFF_MAX              ((uint64_t)(off_t)-1)
> +#define SEND_FD_MP_KEY       "pci_uio_send_fd"
> +
> +struct pci_uio_send_fd_param {
> +       struct rte_pci_addr addr;
> +};
>=20
> int
> pci_uio_read_config(const struct rte_intr_handle *intr_handle,
> @@ -211,6 +219,93 @@ pci_uio_free_resource(struct rte_pci_device *dev,
>                rte_intr_fd_set(dev->intr_handle, -1);
>                rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOW=
N);
>        }
> +
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +               assert(pci_uio_dev_count > 0);
> +               pci_uio_dev_count--;
> +               if (pci_uio_dev_count =3D=3D 0)
> +                       rte_mp_action_unregister(SEND_FD_MP_KEY);
> +       }
> +}
> +
> +static int
> +pci_uio_send_fd(const struct rte_mp_msg *request, const void *peer)
> +{
> +       struct rte_pci_device *dev;
> +       const struct pci_uio_send_fd_param *param =3D
> +               (const struct pci_uio_send_fd_param *)request->param;
> +       struct rte_mp_msg reply =3D {};
> +       int fd;
> +
> +       strlcpy(reply.name, request->name, sizeof(reply.name));
> +       TAILQ_FOREACH(dev, &rte_pci_bus.device_list, next) {
> +               if (!rte_pci_addr_cmp(&dev->addr, &param->addr))
> +                       break;
> +       }
> +
> +       if (dev =3D=3D NULL) {
> +               PCI_LOG(ERR, "Could not find PCI device (" PCI_PRI_FMT ")=
",
> +                       param->addr.domain, param->addr.bus,
> +                       param->addr.devid, param->addr.function);
> +               goto reply;
> +       }
> +
> +       fd =3D rte_intr_fd_get(dev->intr_handle);
> +       if (fd < 0) {
> +               PCI_LOG(ERR, "Could not get fd (" PCI_PRI_FMT ")",
> +                       param->addr.domain, param->addr.bus,
> +                       param->addr.devid, param->addr.function);
> +               goto reply;
> +       }

Should we just return error instead of calling rte_mp_reply when dev =3D=3D=
 NULL or fd < 0?

Thanks,
Chenbo

> +
> +       reply.num_fds =3D 1;
> +       reply.fds[0] =3D fd;
> +reply:
> +       if (rte_mp_reply(&reply, peer) !=3D 0) {
> +               PCI_LOG(ERR, "Failed to send reply: %d (" PCI_PRI_FMT ")"=
,
> +                       rte_errno, param->addr.domain, param->addr.bus,
> +                       param->addr.devid, param->addr.function);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +pci_uio_request_fd(struct rte_pci_device *dev)
> +{
> +       struct rte_mp_msg request =3D {}, *reply;
> +       struct timespec timeout =3D {.tv_sec =3D 1, .tv_nsec =3D 0};
> +       struct pci_uio_send_fd_param *param =3D
> +               (struct pci_uio_send_fd_param *)request.param;
> +       struct rte_mp_reply replies;
> +       int rc;
> +
> +       strlcpy(request.name, SEND_FD_MP_KEY, sizeof(request.name));
> +       memcpy(&param->addr, &dev->addr, sizeof(param->addr));
> +       request.len_param =3D sizeof(*param);
> +
> +       rc =3D rte_mp_request_sync(&request, &replies, &timeout);
> +       if (rc !=3D 0 || replies.nb_received !=3D 1) {
> +               PCI_LOG(ERR, "Failed to request fd from primary: %d (" PC=
I_PRI_FMT ")",
> +                       rte_errno, dev->addr.domain, dev->addr.bus,
> +                       dev->addr.devid, dev->addr.function);
> +               return -1;
> +       }
> +
> +       reply =3D replies.msgs;
> +       if (reply->num_fds !=3D 1) {
> +               PCI_LOG(ERR, "Received unexpected number of fds: %d (" PC=
I_PRI_FMT ")",
> +                       reply->num_fds, dev->addr.domain, dev->addr.bus,
> +                       dev->addr.devid, dev->addr.function);
> +               free(reply);
> +               return -1;
> +       }
> +
> +       rte_intr_fd_set(dev->intr_handle, reply->fds[0]);
> +       free(reply);
> +
> +       return 0;
> }
>=20
> int
> @@ -220,7 +315,7 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
>        char dirname[PATH_MAX];
>        char cfgname[PATH_MAX];
>        char devname[PATH_MAX]; /* contains the /dev/uioX */
> -       int uio_num, fd, uio_cfg_fd;
> +       int rc, uio_num, fd, uio_cfg_fd;
>        struct rte_pci_addr *loc;
>=20
>        loc =3D &dev->addr;
> @@ -232,18 +327,6 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
>                        loc->domain, loc->bus, loc->devid, loc->function);
>                return 1;
>        }
> -       snprintf(devname, sizeof(devname), "/dev/uio%u", uio_num);
> -
> -       /* save fd */
> -       fd =3D open(devname, O_RDWR);
> -       if (fd < 0) {
> -               PCI_LOG(ERR, "Cannot open %s: %s", devname, strerror(errn=
o));
> -               goto error;
> -       }
> -
> -       if (rte_intr_fd_set(dev->intr_handle, fd))
> -               goto error;
> -
>        snprintf(cfgname, sizeof(cfgname),
>                        "/sys/class/uio/uio%u/device/config", uio_num);
>=20
> @@ -270,8 +353,27 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
>                }
>        }
>=20
> -       if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY)
> +       if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY) {
> +               if (pci_uio_request_fd(dev) !=3D 0)
> +                       goto error;
>                return 0;
> +       }
> +
> +       /*
> +        * The uio_pci_generic driver clears the bus master enable bit wh=
en the
> +        * device file is closed, so open it only in the primary process.=
 The
> +        * secondary will get it via SCM_RIGHTS.
> +        */
> +       snprintf(devname, sizeof(devname), "/dev/uio%u", uio_num);
> +       /* save fd */
> +       fd =3D open(devname, O_RDWR);
> +       if (fd < 0) {
> +               PCI_LOG(ERR, "Cannot open %s: %s", devname, strerror(errn=
o));
> +               goto error;
> +       }
> +
> +       if (rte_intr_fd_set(dev->intr_handle, fd))
> +               goto error;
>=20
>        /* allocate the mapping details for secondary processes*/
>        *uio_res =3D rte_zmalloc("UIO_RES", sizeof(**uio_res), 0);
> @@ -280,6 +382,16 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
>                goto error;
>        }
>=20
> +       if (pci_uio_dev_count =3D=3D 0) {
> +               rc =3D rte_mp_action_register(SEND_FD_MP_KEY, pci_uio_sen=
d_fd);
> +               if (rc !=3D 0 && rte_errno !=3D ENOTSUP) {
> +                       PCI_LOG(ERR, "Failed to register multi-process ca=
llback: %d",
> +                               rte_errno);
> +                       goto error;
> +               }
> +       }
> +
> +       pci_uio_dev_count++;
>        strlcpy((*uio_res)->path, devname, sizeof((*uio_res)->path));
>        memcpy(&(*uio_res)->pci_addr, &dev->addr, sizeof((*uio_res)->pci_a=
ddr));
>=20
> --
> 2.46.2
>=20

