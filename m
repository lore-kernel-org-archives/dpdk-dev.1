Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F8EE9E311
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:04:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 930A5402AB;
	Wed, 11 Feb 2026 16:04:48 +0100 (CET)
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com
 [67.231.157.127])
 by mails.dpdk.org (Postfix) with ESMTP id 07AF9402C6
 for <dev@dpdk.org>; Mon,  9 Feb 2026 14:01:53 +0100 (CET)
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 619Cq4Zr3638597; Mon, 9 Feb 2026 13:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=b7G7qhYcDkABCQITaZyYbp0SjlZPrCCNOYY29PlNlAw=; b=m6OxM5Pa9S5u
 5g1JwWeLdDsLOJI1+F8Xz8/k+tdZD+wkREZyeF1ZEtzHQ6gWbqoGHCcLGwy4Z4NU
 f/FxvXw+ztLLGYWEWmVfjavK38ubWOTw4mG7ppu16yg0AY0gYjVYZjMXiKULiqvO
 rJyLbbn1nK5a+9fC/+qb5gpViQRxMFCxgrCAmcd5o+2YI4n5msRaYDwhRuSqB43+
 LHQlGL9LcMHs65k6W1/prT4loZYigg13qhx9IORzzzsQ382M2WAV3+bA+VBf6JbG
 lLzNRZ9Rh3DUcTiQN3a4rt9mjXl1YsRBTwQtvSQU/SRtFCP3TYMKJPlEMFrJYy1d
 29miUYSJxw==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4c6h68w8c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 13:01:52 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 619CRLLO026841; Mon, 9 Feb 2026 08:01:52 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.41])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4c61m3es0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 08:01:52 -0500
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Feb 2026 05:01:51 -0800
Received: from lon-lph85swt.london.corp.akamai.com (172.27.164.43) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.29 via Frontend Transport; Mon, 9 Feb 2026 05:01:51 -0800
Received: by lon-lph85swt.london.corp.akamai.com (Postfix, from userid 37336)
 id 0CD691563219; Mon,  9 Feb 2026 13:01:51 +0000 (GMT)
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 9 Feb 2026 13:01:51 +0000
Message-ID: <DGAG8SE3R0EJ.1WEYABU5T9LXK@akamai.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: Re: [PATCH] common/mlx5: skip ROCE disable for auxiliary SF devices
From: Max Tottenham <mtottenh@akamai.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
X-Mailer: aerc 0.18.2
References: <20260110231510.39095-1-mtottenh@akamai.com>
 <kvgoqx45fofbvrlmklfui5cknnaxfa3t6ayxbrbrm2o4ssqrr2@5jesmo5r2mi5>
In-Reply-To: <kvgoqx45fofbvrlmklfui5cknnaxfa3t6ayxbrbrm2o4ssqrr2@5jesmo5r2mi5>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEwOSBTYWx0ZWRfXwCwvCiM0zTG7
 VJhFDTBPNCIdxuL5NsHDwe4V+sOQcZi66nlS++oVDtg3ruXbeiqKtITaNufffh/umPT4C6Jry/j
 9Sm+FJ1SkvAbTYnTUAm4JlcN/3qhh9FlH+UvukC+2lAdx65hb8XJzRmHkLrJI8at7q+uUdVlvt2
 0VN5uB0uKp3PJgCQwjIFPpcDxASXuKRTBcHLptIng2LYW2nMotJFsgWQ+Vo3vNTce+YB4BTLD1Y
 qN1TQC35nUIlwbcGriLbW1fltonFrWXsp10iiWsl+Os4R0l8UnTsiA5EjA7+dEtFTG4ajXvfoHm
 QVvEcFviJLADTrcFeVRAmCrRcUPnbAFuXhc7JhKiRSKJx4luqIaeq+26Q6bNT/T4xSBQ7GQKG8S
 snS7/QlbnzRmvq8iCJLZ6xHfVku7xFrOI/luU7k586xO3Dh+bVWACitDpOMkKsaTETbtzrF1H6/
 lRnHAmY4wsXYel6Ry6A==
X-Authority-Analysis: v=2.4 cv=XLY9iAhE c=1 sm=1 tr=0 ts=6989dac1 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=X7Ea-ya5AAAA:8
 a=m5HJZjI3joamY_IROZsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l-1-RnINb6sUhdP2J9OZieTHcJd5eUvq
X-Proofpoint-GUID: l-1-RnINb6sUhdP2J9OZieTHcJd5eUvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090109
X-Mailman-Approved-At: Wed, 11 Feb 2026 16:04:47 +0100
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

On Thu Feb 5, 2026 at 2:59 PM GMT, Dariusz Sosnowski wrote:

> Thank you for reporting the issue and the patch.
> Please see comments below.

Responses inline=20

>
> On Sat, Jan 10, 2026 at 11:15:10PM +0000, Max Tottenham wrote:
> > When probing an SF as a vDPA device, mlx5_roce_disable() targets the
> > parent PF address (via mlx5_dev_to_pci_str). This incorrectly attempts
> > to disable ROCE on the parent PF rather than the SF itself.
> >=20
> > This causes vDPA probe failures when the parent PF already has an open
> > IB context (e.g., probed for uplink ports or SF representors).
> >=20
> > For SubFunctions, ROCE is configured via devlink parameters
> > (enable_roce) before device creation. Skip the runtime ROCE disable
> > for auxiliary devices since the devlink configuration is already in
> > effect and targeting the parent PF is incorrect.
> >=20
> > Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> > ---
> >  drivers/common/mlx5/linux/mlx5_common_os.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/commo=
n/mlx5/linux/mlx5_common_os.c
> > index 2867e21618..6fa12e06eb 100644
> > --- a/drivers/common/mlx5/linux/mlx5_common_os.c
> > +++ b/drivers/common/mlx5/linux/mlx5_common_os.c
> > @@ -690,6 +690,19 @@ mlx5_roce_disable(const struct rte_device *dev)
> >  {
> >  	char pci_addr[PCI_PRI_STR_SIZE] =3D { 0 };
> > =20
> > +	/*
> > +	 * For auxiliary devices (SFs), ROCE is configured via devlink
> > +	 * parameters (enable_roce) before device creation. Skip runtime
> > +	 * ROCE disable since mlx5_dev_to_pci_str() returns the parent PF
> > +	 * address, not the SF - disabling ROCE on the parent PF is both
> > +	 * incorrect and may fail if the PF already has an active IB context.
> > +	 */
> > +	if (!mlx5_dev_is_pci(dev)) {
> > +		DRV_LOG(INFO, "Skipping ROCE disable for auxiliary device \"%s\"",
> > +			dev->name);
> > +		return 0;
> > +	}
>
> The logic has a bug as you mentioned, but I don't think
> it would be a good idea to not disable ROCE automatically for SFs.
> Especially since, IIUC, enable_roce option value is not inherited
> from PF when new SF is created and probed.
> It'll move more responsibility to the user regarding
> port configuration.

Ok. I can see arguments for/against here - as I think that for SFs, my
recollection is that you are already required to disable ROCE if not
using the hotplug API. But it's a small enough change to attempt a
disable here.

>
> In my opinion mlx5_roce_disable() should have split logic like so:
>
>     if mlx5_dev_is_pci(dev)
>         // for PCI devices continue as usual:
>         // try disabling ROCE through netlink or sysfs
>     else
>         // for SFs: try disabling ROCE through netlink
>
> This would require some adjustments in mlx5_nl_roce_disable()
> and related code.
> Specifically, devlink attributes should be adjusted when disabling ROCE
> for auxiliary devices:
>
> - DEVLINK_ATTR_BUS_NAME =3D "auxiliary"
> - DEVLINK_ATTR_DEV_NAME =3D device name from rte_device->name
>
> Would you be able to make the necessary changes?
>

Sure. I also found a few other SF hotplug related bugs I'll send along
with the V2.=20

> > +
> >  	if (mlx5_dev_to_pci_str(dev, pci_addr, sizeof(pci_addr)) < 0)
> >  		return -rte_errno;
> >  	/* Firstly try to disable ROCE by Netlink and fallback to sysfs. */
> > --=20
> > 2.51.2
> >=20
>
> Best regards,
> Dariusz Sosnowski

