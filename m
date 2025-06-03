Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F28C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB5C24028E;
	Tue,  3 Jun 2025 10:11:14 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 148314025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 10:11:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B2AFD20100;
 Tue,  3 Jun 2025 10:11:12 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 3 Jun 2025 10:11:08 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCB1@smartserver.smartshare.dk>
In-Reply-To: <20250602223805.816816-3-wathsala.vithanage@arm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
Thread-Index: AdvUDxGu561xbmeURIec+NOT2mKbTQASabOw
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-3-wathsala.vithanage@arm.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Chenbo Xia" <chenbox@nvidia.com>, "Nipun Gupta" <nipun.gupta@amd.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Gaetan Rivet" <grive@u256.net>
Cc: <dev@dpdk.org>, <nd@arm.com>,
 "Honnappa Nagarahalli" <honnappa.nagarahalli@arm.com>,
 "Dhruv Tripathi" <dhruv.tripathi@arm.com>
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

> From: Wathsala Vithanage [mailto:wathsala.vithanage@arm.com]
> Sent: Tuesday, 3 June 2025 00.38

Some nitpicking inline below.

[...]

> diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
> index 5e2e09d5a4..dff750c4d6 100644
> --- a/drivers/bus/pci/bsd/pci.c
> +++ b/drivers/bus/pci/bsd/pci.c
> @@ -650,3 +650,46 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
>=20
>  	return ret;
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 25.07)
> +int
> +rte_pci_tph_enable(struct rte_pci_device *dev, int mode)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(mode);
> +	/* This feature is not yet implemented for BSD */
> +	return -1;

Either set rte_errno and return -1, or return -ENOTSUP.
If one of these two design patterns are already used in a module, please =
use the same design pattern for new functions.
Applies to all dummy functions, BSD and Windows.

[...]

> diff --git a/drivers/bus/pci/bus_pci_driver.h
> b/drivers/bus/pci/bus_pci_driver.h
> index 2cc1119072..b1c2829fc1 100644
> --- a/drivers/bus/pci/bus_pci_driver.h
> +++ b/drivers/bus/pci/bus_pci_driver.h
> @@ -46,6 +46,7 @@ struct rte_pci_device {
>  	char *bus_info;                     /**< PCI bus specific info */
>  	struct rte_intr_handle *vfio_req_intr_handle;
>  				/**< Handler of VFIO request interrupt */
> +	uint8_t tph_enabled;                /**< TPH enabled on this
> device */
>  };
>=20
>  /**
> @@ -194,6 +195,57 @@ struct rte_pci_ioport {
>  	uint64_t len; /* only filled for memory mapped ports */
>  };
>=20
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this structure may change, or be removed, without
> prior
> + * notice
> + *
> + * This structure is passed into the TPH Steering-Tag set or get
> function as an
> + * argument by the caller. Return values are set in the same =
structure
> in st and
> + * ph_ignore fields by the calee.
> + *
> + * Refer to PCI-SIG ECN "Revised _DSM for Cache Locality TPH =
Features"
> for
> + * details.
> + */
> +struct rte_tph_info {
> +	/* Input */
> +	uint32_t cpu_id;	/*Logical CPU id*/
> +	uint32_t cache_level;	/*Cache level relative to CPU.
> l1d=3D0,l2d=3D1,...*/
> +	uint8_t flags;		/*Memory type, procesisng hint etc.*/
> +	uint16_t index;		/*Index in vector table to store the ST*/
> +
> +	/* Output */

I don't think these are Output fields when used in the set() function.
Please update the documentation of this structure accordingly.

> +	uint16_t st;		/*Steering tag returned by the platform*/
> +	uint8_t ph_ignore;	/*Platform ignores PH for the returned
> ST*/
> +};
> +
> +#define RTE_PCI_TPH_MEM_TYPE_MASK		0x1
> +#define RTE_PCI_TPH_MEM_TYPE_SHIFT		0
> +/** Request volatile memory ST */
> +#define RTE_PCI_TPH_MEM_TYPE_VMEM		0
> +/** Request persistent memory ST */
> +#define RTE_PCI_TPH_MEM_TYPE_PMEM		1
> +
> +/** TLP Processing Hints - PCIe 6.0 specification section 2.2.7.1.1 =
*/
> +#define RTE_PCI_TPH_HINT_MASK		0x3
> +#define RTE_PCI_TPH_HINT_SHIFT		1
> +/** Host and device access data equally */
> +#define RTE_PCI_TPH_HINT_BIDIR		0
> +/** Device accesses data more frequently */
> +#define RTE_PCI_TPH_HINT_REQSTR		(1 << RTE_PCI_TPH_HINT_SHIFT)
> +/** Host access data more frequently */
> +#define RTE_PCI_TPH_HINT_TARGET		(2 << RTE_PCI_TPH_HINT_SHIFT)
> +/** Host access data more frequently with a high temporal locality */
> +#define RTE_PCI_TPH_HINT_TARGET_PRIO	(3 << RTE_PCI_TPH_HINT_SHIFT)
> +
> +#define RTE_PCI_TPH_ST_MODE_MASK   0x3
> +/** TPH no ST mode */
> +#define RTE_PCI_TPH_ST_NS_MODE	   0
> +/** TPH interrupt vector mode */
> +#define RTE_PCI_TPH_ST_IV_MODE	   1
> +/** TPH device specific mode */
> +#define RTE_PCI_TPH_ST_DS_MODE	   2
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
> index c20d159218..b5a8ba0a86 100644
> --- a/drivers/bus/pci/linux/pci.c
> +++ b/drivers/bus/pci/linux/pci.c
> @@ -814,3 +814,103 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
>=20
>  	return ret;
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 25.07)
> +int
> +rte_pci_tph_enable(struct rte_pci_device *dev, int mode)
> +{
> +	int ret =3D 0;
> +
> +	switch (dev->kdrv) {
> +#ifdef VFIO_PRESENT
> +	case RTE_PCI_KDRV_VFIO:
> +		if (pci_vfio_is_enabled())
> +			ret =3D pci_vfio_tph_enable(dev, mode);

Is it correct to return 0 when pci_vfio_is_enabled() returns false?

> +		break;
> +#endif
> +	case RTE_PCI_KDRV_IGB_UIO:

Please add "/* fall through */" or similar compiler hint.
Or even better, define a new __rte_fallthrough macro as =
__attribute__((fallthrough)) in rte_common.h.
Refer to [1].

[1]: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html

> +	case RTE_PCI_KDRV_UIO_GENERIC:
> +	default:
> +		ret =3D -ENOTSUP;
> +		break;
> +	}
> +
> +	if (!ret)

This looks wrong. "ret" is not Boolean, so please use "ret =3D=3D 0" =
instead of "!ret".
Applies elsewhere in this patch too, e.g. comparing empty "count" in =
pci_vfio_tph_st_op().

> +		dev->tph_enabled =3D 1;
> +
> +	return ret;
> +}
> +

The above comments apply to all four functions.

[...]

> diff --git a/drivers/bus/pci/linux/pci_vfio.c
> b/drivers/bus/pci/linux/pci_vfio.c
> index 5317170231..bdbeb38658 100644
> --- a/drivers/bus/pci/linux/pci_vfio.c
> +++ b/drivers/bus/pci/linux/pci_vfio.c
> @@ -12,6 +12,7 @@
>  #include <stdbool.h>
>=20
>  #include <rte_log.h>
> +#include <eal_export.h>
>  #include <rte_pci.h>
>  #include <rte_bus_pci.h>
>  #include <rte_eal_paging.h>
> @@ -1316,6 +1317,175 @@ pci_vfio_mmio_write(const struct =
rte_pci_device
> *dev, int bar,
>  	return pwrite(fd, buf, len, offset + offs);
>  }
>=20
> +static int
> +pci_vfio_tph_ioctl(const struct rte_pci_device *dev, struct
> vfio_pci_tph *pci_tph)
> +{
> +	const struct rte_intr_handle *intr_handle =3D dev->intr_handle;
> +	int vfio_dev_fd =3D 0, ret =3D 0;
> +
> +	vfio_dev_fd =3D rte_intr_dev_fd_get(intr_handle);
> +	if (vfio_dev_fd < 0) {
> +		ret =3D -EINVAL;

This should be ret =3D rte_errno.
Or even better: Other code in /drivers/bus/pci/linux/pci_vfio.c follows =
the design pattern of setting rte_errno and returning -1 on error. =
Please use the same design pattern.
Applies to all four functions.

> +		goto out;
> +	}
> +
> +	ret =3D ioctl(vfio_dev_fd, VFIO_DEVICE_PCI_TPH, pci_tph);
> +out:
> +	return ret;
> +}
> +
> +static int
> +pci_vfio_tph_st_op(const struct rte_pci_device *dev,
> +		    struct rte_tph_info *info, size_t count,
> +		    enum rte_pci_st_op op)
> +{
> +	int ret =3D 0;
> +	size_t argsz =3D 0, i;
> +	struct vfio_pci_tph *pci_tph =3D NULL;
> +	uint8_t mem_type =3D 0, hint =3D 0;
> +
> +	if (!count) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	argsz =3D sizeof(struct vfio_pci_tph) +
> +		count * sizeof(struct vfio_pci_tph_entry);
> +
> +	pci_tph =3D rte_zmalloc(NULL, argsz, 0);
> +	if (!pci_tph) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	pci_tph->argsz =3D argsz;
> +	pci_tph->count =3D count;
> +
> +	switch (op) {
> +	case RTE_PCI_TPH_ST_GET:
> +		pci_tph->flags =3D VFIO_DEVICE_TPH_GET_ST;
> +		break;
> +	case RTE_PCI_TPH_ST_SET:
> +		pci_tph->flags =3D VFIO_DEVICE_TPH_SET_ST;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		pci_tph->ents[i].cpu_id =3D info[i].cpu_id;
> +		pci_tph->ents[i].cache_level =3D info[i].cache_level;
> +
> +		mem_type =3D info[i].flags & RTE_PCI_TPH_MEM_TYPE_MASK;
> +		switch (mem_type) {
> +		case RTE_PCI_TPH_MEM_TYPE_VMEM:
> +			pci_tph->ents[i].flags |=3D VFIO_TPH_MEM_TYPE_VMEM;
> +			break;
> +		case RTE_PCI_TPH_MEM_TYPE_PMEM:
> +			pci_tph->ents[i].flags |=3D VFIO_TPH_MEM_TYPE_PMEM;
> +			break;
> +		default:
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		hint =3D info[i].flags & RTE_PCI_TPH_HINT_MASK;
> +		switch (hint) {
> +		case RTE_PCI_TPH_HINT_BIDIR:
> +			pci_tph->ents[i].flags |=3D VFIO_TPH_HINT_BIDIR;
> +			break;
> +		case RTE_PCI_TPH_HINT_REQSTR:
> +			pci_tph->ents[i].flags |=3D VFIO_TPH_HINT_REQSTR;
> +			break;
> +		case RTE_PCI_TPH_HINT_TARGET:
> +			pci_tph->ents[i].flags |=3D VFIO_TPH_HINT_TARGET;
> +			break;
> +		case RTE_PCI_TPH_HINT_TARGET_PRIO:
> +			pci_tph->ents[i].flags |=3D VFIO_TPH_HINT_TARGET_PRIO;
> +			break;
> +		default:
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		if (op =3D=3D RTE_PCI_TPH_ST_SET)
> +			pci_tph->ents[i].index =3D info[i].index;
> +	}
> +
> +	ret =3D pci_vfio_tph_ioctl(dev, pci_tph);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * Kernel returns steering-tag and ph-ignore bits for
> +	 * RTE_PCI_TPH_ST_SET too, therefore copy output for
> +	 * both RTE_PCI_TPH_ST_SET and RTE_PCI_TPH_ST_GET
> +	 * cases.
> +	 */
> +	for (i =3D 0; i < count; i++) {
> +		info[i].st =3D pci_tph->ents[i].st;
> +		info[i].ph_ignore =3D pci_tph->ents[i].ph_ignore;
> +	}
> +
> +out:
> +	if (pci_tph)
> +		rte_free(pci_tph);
> +	return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_enable, 25.07)
> +int
> +pci_vfio_tph_enable(const struct rte_pci_device *dev, int mode)
> +{
> +	int ret;
> +
> +	if (!(mode ^ (mode & VFIO_TPH_ST_MODE_MASK))) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	} else
> +		mode &=3D VFIO_TPH_ST_MODE_MASK;
> +
> +	struct vfio_pci_tph pci_tph =3D {
> +		.argsz =3D sizeof(struct vfio_pci_tph),
> +		.flags =3D VFIO_DEVICE_TPH_ENABLE | mode,
> +		.count =3D 0
> +	};
> +
> +	ret =3D pci_vfio_tph_ioctl(dev, &pci_tph);
> +out:
> +	return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_disable, 25.07)
> +int
> +pci_vfio_tph_disable(const struct rte_pci_device *dev)
> +{
> +	struct vfio_pci_tph pci_tph =3D {
> +		.argsz =3D sizeof(struct vfio_pci_tph),
> +		.flags =3D VFIO_DEVICE_TPH_DISABLE,
> +		.count =3D 0
> +	};
> +
> +	return pci_vfio_tph_ioctl(dev, &pci_tph);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_st_get, 25.07)
> +int
> +pci_vfio_tph_st_get(const struct rte_pci_device *dev,
> +		    struct rte_tph_info *info, size_t count)
> +{
> +	return pci_vfio_tph_st_op(dev, info, count, RTE_PCI_TPH_ST_GET);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_st_set, 25.07)
> +int
> +pci_vfio_tph_st_set(const struct rte_pci_device *dev,
> +		    struct rte_tph_info *info, size_t count)
> +{
> +	return pci_vfio_tph_st_op(dev, info, count, RTE_PCI_TPH_ST_SET);
> +}
> +
>  int
>  pci_vfio_is_enabled(void)
>  {
> diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
> index 38109844b9..d2ec370320 100644
> --- a/drivers/bus/pci/private.h
> +++ b/drivers/bus/pci/private.h
> @@ -335,4 +335,12 @@ rte_pci_dev_iterate(const void *start,
>  int
>  rte_pci_devargs_parse(struct rte_devargs *da);
>=20
> +/*
> + * TPH Steering-Tag operation types.
> + */
> +enum rte_pci_st_op {
> +	RTE_PCI_TPH_ST_SET, /* Set TPH Steering - Tags */
> +	RTE_PCI_TPH_ST_GET  /* Get TPH Steering - Tags */
> +};
> +
>  #endif /* _PCI_PRIVATE_H_ */
> diff --git a/drivers/bus/pci/rte_bus_pci.h
> b/drivers/bus/pci/rte_bus_pci.h
> index 19a7b15b99..e4d4780f54 100644
> --- a/drivers/bus/pci/rte_bus_pci.h
> +++ b/drivers/bus/pci/rte_bus_pci.h
> @@ -31,6 +31,7 @@ extern "C" {
>  struct rte_pci_device;
>  struct rte_pci_driver;
>  struct rte_pci_ioport;
> +struct rte_tph_info;
>=20
>  struct rte_devargs;
>=20
> @@ -312,6 +313,72 @@ void rte_pci_ioport_read(struct rte_pci_ioport =
*p,
>  void rte_pci_ioport_write(struct rte_pci_ioport *p,
>  		const void *data, size_t len, off_t offset);
>=20
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Enable TLP Processing Hints (TPH) in the endpoint device.
> + *
> + * @param dev
> + *   A pointer to a rte_pci_device structure describing the device
> + *   to use.
> + * @param mode
> + *   TPH mode the device must operate in.

The values of the "mode" parameter should be well defined in a DPDK =
public API.
I cannot find them.

The return value is missing from the documentation.
For all four functions here.

> + */
> +__rte_experimental
> +int rte_pci_tph_enable(struct rte_pci_device *dev, int mode);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Disable TLP Processing Hints (TPH) in the endpoint device.
> + *
> + * @param dev
> + *   A pointer to a rte_pci_device structure describing the device
> + *   to use.
> + */
> +__rte_experimental
> +int rte_pci_tph_disable(struct rte_pci_device *dev);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Get PCI Steering-Tags (STs) for a list of stashing targets.
> + *
> + * @param mode
> + *   TPH mode the device must operate in.
> + * @param info
> + *   An array of rte_tph_info objects, each describing the target
> + *   cpu-id, cache-level, etc. Steering-tags for each target is
> + *   eturned via info array.
> + * @param count
> + *   The number of elements in the info array.
> + */
> +__rte_experimental
> +int rte_pci_tph_st_get(const struct rte_pci_device *dev,
> +		struct rte_tph_info *info, size_t count);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Set PCI Steering-Tags (STs) for a list of stashing targets.
> + *
> + * @param mode
> + *   TPH mode the device must operate in.
> + * @param info
> + *   An array of rte_tph_info objects, each describing the target
> + *   cpu-id, cache-level, etc. Steering-tags for each target is
> + *   eturned via info array.
> + * @param count
> + *   The number of elements in the info array.
> + */
> +__rte_experimental
> +int rte_pci_tph_st_set(const struct rte_pci_device *dev,
> +		struct rte_tph_info *info, size_t count);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/drivers/bus/pci/windows/pci.c
> b/drivers/bus/pci/windows/pci.c
> index e7e449306e..218e667a5a 100644
> --- a/drivers/bus/pci/windows/pci.c
> +++ b/drivers/bus/pci/windows/pci.c
> @@ -511,3 +511,46 @@ rte_pci_scan(void)
>=20
>  	return ret;
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 25.07)
> +int
> +rte_pci_tph_enable(struct rte_pci_device *dev, int mode)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(mode);
> +	/* This feature is not yet implemented for windows */
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_disable, 25.07)
> +int
> +rte_pci_tph_disable(struct rte_pci_device *dev)
> +{
> +	RTE_SET_USED(dev);
> +	/* This feature is not yet implemented for windows */
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_get, 25.07)
> +int
> +rte_pci_tph_st_get(const struct rte_pci_device *dev,
> +		   struct rte_tph_info *info, size_t count)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(info);
> +	RTE_SET_USED(count);
> +	/* This feature is not yet implemented for windows */
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_set, 25.07)
> +int
> +rte_pci_tph_st_set(const struct rte_pci_device *dev,
> +		   struct rte_tph_info *info, size_t count)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(info);
> +	RTE_SET_USED(count);
> +	/* This feature is not yet implemented for windows */
> +	return -1;
> +}
> diff --git a/lib/pci/rte_pci.h b/lib/pci/rte_pci.h
> index 9a50a12142..da9cd666bf 100644
> --- a/lib/pci/rte_pci.h
> +++ b/lib/pci/rte_pci.h
> @@ -137,6 +137,21 @@ extern "C" {
>  /* Process Address Space ID (RTE_PCI_EXT_CAP_ID_PASID) */
>  #define RTE_PCI_PASID_CTRL		0x06    /* PASID control register
> */
>=20
> +/* TPH Requester */
> +#define RTE_PCI_TPH_CAP            4       /* capability register */
> +#define RTE_PCI_TPH_CAP_ST_NS      0x00000001 /* No ST Mode Supported
> */
> +#define RTE_PCI_TPH_CAP_ST_IV      0x00000002 /* Interrupt Vector =
Mode
> Supported */
> +#define RTE_PCI_TPH_CAP_ST_DS      0x00000004 /* Device Specific Mode
> Supported */
> +#define RTE_PCI_TPH_CAP_EXT_TPH    0x00000100 /* Ext TPH Requester
> Supported */
> +#define RTE_PCI_TPH_CAP_LOC_MASK   0x00000600 /* ST Table Location */
> +#define RTE_PCI_TPH_LOC_NONE       0x00000000 /* Not present */
> +#define RTE_PCI_TPH_LOC_CAP        0x00000200 /* In capability */
> +#define RTE_PCI_TPH_LOC_MSIX       0x00000400 /* In MSI-X */
> +#define RTE_PCI_TPH_CAP_ST_MASK    0x07FF0000 /* ST Table Size */
> +#define RTE_PCI_TPH_CAP_ST_SHIFT   16      /* ST Table Size shift */
> +#define RTE_PCI_TPH_BASE_SIZEOF    0xc     /* Size with no ST table =
*/
> +
> +
>  /** Formatting string for PCI device identifier: Ex: 0000:00:01.0 */
>  #define PCI_PRI_FMT "%.4" PRIx32 ":%.2" PRIx8 ":%.2" PRIx8 ".%" PRIx8
>  #define PCI_PRI_STR_SIZE sizeof("XXXXXXXX:XX:XX.X")
> --
> 2.43.0

